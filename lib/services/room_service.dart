import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class RoomService {
  static Future<List<PhongViewModel>> getRooms() async {
    final url = Uri.parse('$apiDomain/api/phong-thue');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        List content = resBody['content'];
        List<PhongViewModel> result = content
            .map((item) => PhongViewModel.fromMap(item))
            .toList();
        return result;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<PhongViewModel> getRoomByID(int id) async {
    final url = Uri.parse('$apiDomain/api/phong-thue/$id');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        var content = resBody['content'];
        return PhongViewModel.fromMap(content);
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<List<PhongViewModel>> getRoomByLocation(int maViTri) async {
    final url = Uri.parse(
      '$apiDomain/api/phong-thue/lay-phong-theo-vi-tri?maViTri=$maViTri',
    );

    try {
      final respone = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (respone.statusCode == 200) {
        var resBody = jsonDecode(respone.body);
        List content = resBody['content'];
        List<PhongViewModel> result = content
            .map((item) => PhongViewModel.fromMap(item))
            .toList();
        return result;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
