import 'package:flutter/material.dart';
import 'package:myanilab/Core/API/api.dart';
import 'package:myanilab/Core/Models/user.dart';
import 'package:myanilab/Core/Utils/mal_exceptions.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  MalException? _error;

  User? get user => _user;
  MalException? get error => _error;

  void reset() {
    _user = null;
    _error = null;
    notifyListeners();
  }

  Future<void> getUser() async {
    try {
      _user = await API.getUser();
      _error = null;
      notifyListeners();
    } on MalException catch (e) {
      _error = e;
      notifyListeners();
    }
  }
}
