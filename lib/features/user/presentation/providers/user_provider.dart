import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'Guest';
  String _email = '';
  String _phone = '';
  bool _isLoggedIn = false;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  bool get isLoggedIn => _isLoggedIn;

  void updateProfile(String name, String email, String phone) {
    _name = name;
    _email = email;
    _phone = phone;
    notifyListeners();
  }

  void login(String name, String email) {
    _name = name;
    _email = email;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _name = 'Guest';
    _email = '';
    _phone = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}
