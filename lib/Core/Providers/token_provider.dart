import 'package:flutter/material.dart';
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
    notifyListeners();
  }
}
