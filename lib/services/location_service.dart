import 'package:airbnb_cybersoft/models/location_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class LocationService {
  static Future<List<ViTriViewModel>> getLocations() async {
    final url = Uri.parse('$apiDomain/api/vi-tri');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'tokenCybersoft': token},
      );
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        List content = resBody['content'];
        List<ViTriViewModel> result = content
            .map((item) => ViTriViewModel.fromMap(item))
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
