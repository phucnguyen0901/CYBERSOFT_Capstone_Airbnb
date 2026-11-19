import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class UserService {
  static Future<UserResponse> getUserInfoByID(int id) async {
    final url = Uri.parse('$apiDomain/api/users/$id');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        UserResponse result = UserResponse.fromMap(resBody);
        return result;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<UserResponse> updateUser(
    int id,
    Map<String, dynamic> updateData,
  ) async {
    final url = Uri.parse('$apiDomain/api/users/$id');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
        body: jsonEncode(updateData),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = jsonDecode(response.body);
        UserResponse result = UserResponse.fromMap(resBody);
        return result;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
