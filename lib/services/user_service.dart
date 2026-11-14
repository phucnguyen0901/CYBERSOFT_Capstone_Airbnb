import 'package:airbnb_cybersoft/models/login_model.dart';
import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class UserService {
  static Future<DangNhapView> login() async {
    final url = Uri.parse('$apiDomain/api/auth/signin');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        var content = resBody['content'];
        DangNhapView result = DangNhapView.fromMap(content);
        return result;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<ThongTinNguoiDung> signup() async {
    final url = Uri.parse('$apiDomain/api/auth/signup');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        var content = resBody['content'];
        ThongTinNguoiDung result = ThongTinNguoiDung.fromMap(content);
        return result;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}

/* model mẫu
"content": {
    "id": 73395,
    "name": "NPN",
    "email": "npntest@email.com",
    "password": "",
    "phone": "string",
    "birthday": "string",
    "avatar": "",
    "gender": true,
    "role": "USER"
  },
*/
