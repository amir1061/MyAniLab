import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:myanilab/Core/Models/token.dart';

class TokenProvider extends ChangeNotifier {
  Token? _token;

  TokenProvider() {
    _init();
  }

  _init() async {
    token = await Token.fromStorage();
  }

  Token? get token => _token;

  set token(Token? t) {
    _token = t;
    if (t == null) {
      const FlutterSecureStorage().deleteAll();
      GetIt.I.reset();
    } else {
      GetIt.I.registerSingleton<Token>(t);
    }
    notifyListeners();
  }
}
