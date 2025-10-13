import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final String baseUrl = dotenv.env['API_URL']!;

  Future<Map<String, dynamic>> get(String path, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$path'),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }
}
