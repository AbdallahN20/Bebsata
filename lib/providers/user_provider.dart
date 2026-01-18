import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'John Doe';
  String _email = 'john@example.com';
  String _phone = '+1 123-456-7890';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;

  void updateProfile(String name, String email, String phone) {
    _name = name;
    _email = email;
    _phone = phone;
    notifyListeners();
  }
}