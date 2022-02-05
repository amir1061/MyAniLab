import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:myanilab/Core/API/api.dart';
import 'package:myanilab/Core/Models/token.dart';
import 'package:myanilab/Core/Utils/mal_exceptions.dart';

class TokenProvider extends ChangeNotifier {
  bool _isLoading = true;
  Token? _token;

  TokenProvider() {
    _init();
  }

  _init() async {
    token = await Token.fromStorage();
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  Token? get token => _token;

  set token(Token? t) {
    _token = t;
    if (t == null) {
      const FlutterSecureStorage().deleteAll();
      GetIt.I.reset();
    } else {
      GetIt.I.registerSingleton<Token>(t);
    }
  }

  setToken(Token? t) async {
    token = t;
    notifyListeners();
  }

  getToken(String code) async {
    _isLoading = true;
    notifyListeners();
    try {
      token = await API.getToken(code);
      _isLoading = false;
      notifyListeners();
    } on MalException catch (_) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
