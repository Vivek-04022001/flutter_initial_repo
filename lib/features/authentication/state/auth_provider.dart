import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  bool _isRememberMe = false;
  bool get isRememberMe => _isRememberMe;
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }
}
