import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  static dynamic _user;
  dynamic get user => _user;
  set user(dynamic user) {
    _user = user;
    notifyListeners();
  }
}
