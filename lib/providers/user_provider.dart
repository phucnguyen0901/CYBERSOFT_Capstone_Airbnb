import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  ThongTinNguoiDung? _user;

  ThongTinNguoiDung get user => _user!;

  void loadUser(ThongTinNguoiDung user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
