import 'dart:convert';

import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
const _keyUserInfo = 'user_info';
const _keyAccessToken = 'access_token';

Future<void> saveAccessToken({required String token}) async {
  await storage.write(key: _keyAccessToken, value: token);
}

Future<void> saveUserInfo({required ThongTinNguoiDung user}) async {
  String userString = jsonEncode(user.toMap());
  await storage.write(key: _keyUserInfo, value: userString);
}

Future<String?> getAccessToken() async {
  return await storage.read(key: _keyAccessToken);
}

Future<ThongTinNguoiDung?> getUserInfo() async {
  final userString = await storage.read(key: _keyUserInfo);
  if (userString != null) {
    return ThongTinNguoiDung.fromMap(jsonDecode(userString));
  }
  return null;
}

Future<void> clearToken() async {
  await storage.delete(key: _keyAccessToken);
}

Future<void> clearUserInfo() async {
  await storage.delete(key: _keyUserInfo);
}
