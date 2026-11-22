import 'package:airbnb_cybersoft/models/login_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class AuthService {
  static Future<AuthResponse> signin({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$apiDomain/api/auth/signin');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'tokenCybersoft': token,
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes));
        return AuthResponse.fromMap(result);
      } else {
        throw Exception(
          'Failed: HTTP ${response.statusCode}; response: ${response.body}',
        );
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<bool> signup(Map<String, dynamic> signupData) async {
    final url = Uri.parse('$apiDomain/api/auth/signup');

    try {
      var success = false;
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
        body: jsonEncode(signupData),
      );
      if (response.statusCode == 200) {
        success = true;
        return success;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception('Erorr when sigup: $err');
    }
  }
}
