import 'package:airbnb_cybersoft/models/location_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class LocationService {
  static Future<List<ViTriViewModel>> getLocations({
    required String keyword,
  }) async {
    final url = Uri.parse(
      '$apiDomain/api/vi-tri/phan-trang-tim-kiem?pageIndex=1&pageSize=50&keyword=$keyword',
    );

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        var content = resBody['content'];
        List data = content['data'];
        List<ViTriViewModel> result = data
            .map((item) => ViTriViewModel.fromMap(item))
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

  static Future<ViTriViewModel> getLocationByID({required int maViTri}) async {
    final url = Uri.parse('$apiDomain/api/vi-tri/$maViTri');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        var content = resBody['content'];
        ViTriViewModel result = ViTriViewModel.fromMap(content);
        return result;
      } else {
        throw Exception('Error');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
