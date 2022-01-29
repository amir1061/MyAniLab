import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myanilab/Core/Utils/mal_exceptions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future push(BuildContext context, Widget page) async {
  await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

Future<void> launchUrl(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception('Url can not be launched');
    }
  } catch (_) {
    rethrow;
  }
}

String getRandomHash([int length = 128]) {
  final Random _random = Random.secure();
  var values = List<int>.generate(length, (i) => _random.nextInt(256));
  return base64Url.encode(values);
}

dynamic parseResponse(http.Response response) {
  if (response.statusCode == 200) return json.decode(response.body);
  final error = json.decode(response.body)['error'];
  switch (response.statusCode) {
    case 400:
      throw BadRequestException(error);
    case 401:
      throw UnauthorisedException(error);
    case 403:
      throw ForbidenException(error);
    case 404:
      throw NotFoundException(error);
    case 500:
    default:
      throw FetchDataException(
        'Error occured while Communication with Server with StatusCode ${response.statusCode}',
      );
  }
}
