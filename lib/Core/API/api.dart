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
  static Future<Token> getToken(String code) async {
    try {
      log(dotenv.env['oAuthUrl']!);
      final resp = await http.post(
        Uri.parse(dotenv.env['oAuthUrl']!),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        body:
            'client_id=${dotenv.env['clientId']}&code=$code&code_verifier=${dotenv.env['codeVerifier']}&grant_type=authorization_code',
      );
      log(resp.body.toString());
      final data = parseResponse(resp);
      final t = Token.fromJson(data);
      return t;
    } on SocketException catch (_) {
      throw Exception('No internet!');
    } catch (_) {
      rethrow;
    }
  }

  static Future<Token> refreshToken() async {
    try {
      log('refreshing token');
      final resp = await http.post(
        Uri.parse(dotenv.env['oAuthUrl']!),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        body:
            'client_id=${dotenv.env['clientId']}&refresh_token=${GetIt.I.get<Token>().refreshToken}&grant_type=refresh_token',
      );
      final data = parseResponse(resp);
      final t = Token.fromJson(data);
      return t;
    } on SocketException catch (_) {
      throw Exception('No internet!');
    } on UnauthorisedException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  static Future<User> getUser() async {
    try {
      final resp = await http.get(
        Uri.parse(
            '${dotenv.env['baseUrl']}/users/@me?fields=email,anime_statistics'),
        headers: {
          HttpHeaders.authorizationHeader: GetIt.I.get<Token>().token,
        },
      );
      log(resp.statusCode.toString());
      log(resp.body);
      final data = parseResponse(resp);
      return User.fromJson(data);
    } on SocketException catch (_) {
      throw Exception('No internet!');
    } on UnauthorisedException catch (_) {
      await refreshToken();
      return await getUser();
    }
  }
}
