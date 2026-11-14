import 'dart:convert';

import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyUserInfo = 'user_info';
  static const _keyAccessToken = 'access_token';

  static Future<void> saveUserInfo({
    required String token,
    required ThongTinNguoiDung user,
  }) async {
    await _storage.write(key: _keyAccessToken, value: token);

    String userString = jsonEncode(user.toMap());
    await _storage.write(key: _keyUserInfo, value: userString);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  static Future<ThongTinNguoiDung?> getUserInfo() async {
    final userString = await _storage.read(key: _keyUserInfo);
    if (userString != null) {
      return ThongTinNguoiDung.fromMap(jsonDecode(userString));
    }
    return null;
  }

  static Future<void> clearStorage() async {
    await _storage.deleteAll();
  }
}
