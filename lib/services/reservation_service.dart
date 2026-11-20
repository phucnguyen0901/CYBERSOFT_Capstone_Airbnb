import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class ReservationService {
  static Future<List<DatPhongViewModel>> getRoomsByUserID(
    int maNguoiDung,
  ) async {
    final url = Uri.parse(
      '$apiDomain/api/dat-phong/lay-theo-nguoi-dung/$maNguoiDung',
    );

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        List content = resBody['content'];
        List<DatPhongViewModel> result = content
            .map((item) => DatPhongViewModel.fromMap(item))
            .toList();
        return result;
      } else {
        throw Exception(
          'Failed: HTTP ${response.statusCode}; response: ${response.body}',
        );
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  static Future<bool> booking(Map<String, dynamic> reserveInfo) async {
    final url = Uri.parse('$apiDomain/api/dat-phong');

    try {
      var success = false;
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
        body: jsonEncode(reserveInfo),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        success = true;
        return success;
      } else {
        throw Exception(
          'Failed: HTTP ${response.statusCode}; response: ${response.body}',
        );
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
