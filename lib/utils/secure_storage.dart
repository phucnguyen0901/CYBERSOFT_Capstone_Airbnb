import 'dart:convert';

import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
const _keyUserInfo = 'user_info';
const _keyAccessToken = 'access_token';

Future<void> saveUserInfo({
  required String token,
  required ThongTinNguoiDung user,
}) async {
  await storage.write(key: _keyAccessToken, value: token);

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

Future<void> clearStorage() async {
  await storage.deleteAll();
}
