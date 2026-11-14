import 'package:airbnb_cybersoft/models/login_model.dart';
import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class AuthService {
  static Future<List<dynamic>> signin(Map<String, dynamic> signinData) async {
    final url = Uri.parse('$apiDomain/api/auth/sigin');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
        body: jsonEncode(signinData),
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        Map<String, dynamic> content = resBody['content'];
        DangNhapView result = DangNhapView.fromMap(content['user']);
        String token = content['token'];
        return [result, token];
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<ThongTinNguoiDung> signup(
    Map<String, dynamic> signupData,
  ) async {
    final url = Uri.parse('$apiDomain/api/auth/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
        body: jsonEncode(signupData),
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        Map<String, dynamic> content = resBody['content'];
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
