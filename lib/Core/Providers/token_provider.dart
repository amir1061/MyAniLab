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
    await setToken(await Token.fromStorage());
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  Token? get token => _token;

  setToken(Token? t) async {
    _token = t;
    if (t == null) {
      await const FlutterSecureStorage().deleteAll();
      await GetIt.I.reset();
    } else {
      GetIt.I.registerSingleton<Token>(t);
    }
  }

  logOut() async {
    _isLoading = true;
    notifyListeners();
    await setToken(null);
    //? this future is here to allow the rebuild of all the other pages after log out
    await Future.delayed(const Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }

  getToken(String code) async {
    _isLoading = true;
    notifyListeners();
    try {
      await setToken(await API.getToken(code));
      _isLoading = false;
      notifyListeners();
    } on MalException catch (_) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
