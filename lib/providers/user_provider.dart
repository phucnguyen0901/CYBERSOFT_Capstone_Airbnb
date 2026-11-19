import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:airbnb_cybersoft/services/user_service.dart';
import 'package:airbnb_cybersoft/utils/secure_storage.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  ThongTinNguoiDung? _user;

  ThongTinNguoiDung get user => _user!;

  void loadUser(ThongTinNguoiDung user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    notifyListeners();
  }

  Future<UserResponse> getUserInfo({required int id}) async {
    final result = await UserService.getUserInfoByID(id);
    return result;
  }

  Future<void> updateUserInfo({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String birthday,
    required bool gender,
    required String role,
  }) async {
    final updateData = {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      'role': role,
    };
    await UserService.updateUser(id, updateData);
    final result = await UserService.getUserInfoByID(id);
    await clearUserInfo();
    clearUser();
    await saveUserInfo(user: result.user);
    loadUser(result.user);
  }
}
