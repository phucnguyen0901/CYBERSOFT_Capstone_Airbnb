import 'package:airbnb_cybersoft/models/comment_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

final apiDomain = dotenv.env['API_DOMAIN_URL'];
final token = dotenv.env['CYBERSOFT_TOKEN'] ?? '';

class CommentService {
  static Future<List<ModelBinhLuanTheoPhong>> getCommentByRoomID({
    required int maPhong,
  }) async {
    final url = Uri.parse(
      '$apiDomain/api/binh-luan/lay-binh-luan-theo-phong/$maPhong',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'tokenCybersoft': token,
        },
      );
      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        List<dynamic> content = resBody['content'];
        List<ModelBinhLuanTheoPhong> result = content
            .map((item) => ModelBinhLuanTheoPhong.fromMap(item))
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

  static Future<BinhLuanViewModel> postComment({
    required String accessToken,
    required BinhLuanViewModel comment,
  }) async {
    final url = Uri.parse('$apiDomain/api/binh-luan');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': accessToken,
          'tokenCybersoft': token,
        },
        body: jsonEncode(comment.toMap()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final resBody = jsonDecode(response.body);
        var content = resBody['content'];
        var result = BinhLuanViewModel.fromMap(content);
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
}
