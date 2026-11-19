import 'package:airbnb_cybersoft/models/login_model.dart';
import 'package:airbnb_cybersoft/services/auth_service.dart';
import 'package:airbnb_cybersoft/utils/secure_storage.dart';
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

  Future<AuthContent> signIn({
    required String email,
    required String password,
  }) async {
    setLoading(true);
    try {
      return await _signInAndPersist(email: email, password: password);
    } finally {
      setLoading(false);
    }
  }

  Future<AuthContent> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    setLoading(true);
    try {
      final success = await AuthService.signup({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      });
      if (!success) {
        throw StateError('Unable to create account');
      }

      return await _signInAndPersist(email: email, password: password);
    } finally {
      setLoading(false);
    }
  }

  Future<AuthContent> _signInAndPersist({
    required String email,
    required String password,
  }) async {
    final result = await AuthService.signin(email: email, password: password);
    await saveAccessToken(token: result.content.token);
    await saveUserInfo(user: result.content.user);
    return result.content;
  }
}
