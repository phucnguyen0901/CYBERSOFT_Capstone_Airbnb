import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool _isLoading = false;
  String _accessToken = '';

  bool get isLogin => _isLogin;
  bool get isLoading => _isLoading;
  String get accessToken => _accessToken;

  void setLogin(String token) {
    _isLogin = true;
    _accessToken = token;
    notifyListeners();
  }

  void setLogout() {
    _isLogin = false;
    _accessToken = '';
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
