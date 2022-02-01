import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:myanilab/Core/Models/token.dart';
import 'package:http/http.dart' as http;
import 'package:myanilab/Core/Models/user.dart';
import 'package:myanilab/Core/Utils/helpers.dart';
import 'package:myanilab/Core/Utils/mal_exceptions.dart';

class API {
  static final oAuthUrl = dotenv.env['oAuthUrl'] ?? '';
  static final baseUrl = dotenv.env['baseUrl'] ?? '';
  static final clientId = dotenv.env['clientId'] ?? '';
  static final codeVerifier = dotenv.env['codeVerifier'] ?? '';

  static Future<Token> getToken(String code) async {
    try {
      final resp = await http.post(
        Uri.parse(oAuthUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        body:
            'client_id=$clientId&code=$code&code_verifier=$codeVerifier&grant_type=authorization_code',
      );
      log(resp.body.toString());
      final json = parseResponse(resp);
      return Token.fromJson(json);
    } on SocketException catch (_) {
      throw NoNetworkException('please check your network and try again!');
    } on FormatException catch (_) {
      throw MalFormatException('failed parsing response!');
    } catch (e) {
      throw UnknownExcption(e.toString());
    }
  }

  static Future<Token> refreshToken() async {
    try {
      log('refreshing token');
      final resp = await http.post(
        Uri.parse(oAuthUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        body:
            'client_id=$clientId&refresh_token=${GetIt.I.get<Token>().refreshToken}&grant_type=refresh_token',
      );
      final json = parseResponse(resp);
      return Token.fromJson(json);
    } on SocketException catch (_) {
      throw NoNetworkException('please check your network and try again!');
    } on UnauthorisedException catch (_) {
      //?What happens if refreshing token failed
      rethrow;
    } on FormatException catch (_) {
      throw MalFormatException('failed parsing response!');
    } catch (e) {
      throw UnknownExcption(e.toString());
    }
  }

  static Future<User> getUser() async {
    try {
      final resp = await http.get(
        Uri.parse(
          '$baseUrl/users/@me?fields=picture,gender,birthday,location,anime_statistics,time_zone,is_supporter',
        ),
        headers: {HttpHeaders.authorizationHeader: GetIt.I.get<Token>().token},
      );
      log(resp.statusCode.toString());
      log(resp.body);
      final json = parseResponse(resp);
      return User.fromJson(json);
    } on SocketException catch (_) {
      throw NoNetworkException('please check your network and try again!');
    } on UnauthorisedException catch (_) {
      await refreshToken();
      return await getUser();
    } on FormatException catch (_) {
      throw MalFormatException('failed parsing response!');
    } catch (e) {
      throw UnknownExcption(e.toString());
      // throw UnknownExcption('an unknown error has occured!');
    }
  }
}
