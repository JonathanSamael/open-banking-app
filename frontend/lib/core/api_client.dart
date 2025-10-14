import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  
  final String _baseUrl = dotenv.env['API_URL']!;

  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, String>> _getHeaders({String? authToken}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (authToken != null && authToken.isNotEmpty) {
      headers['Authorization'] = authToken.startsWith('Bearer ') ? authToken : 'Bearer $authToken';
    }
    return headers;
  }

  Future<http.Response> get(
    String path,{
    Map<String, String>? queryParameters,
    String? authToken,
  }) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: queryParameters);
    final headers = await _getHeaders(authToken: authToken);
    return _client.get(uri, headers: headers);
  }

  Future<http.Response> post(
    String path, {
    Map<String, dynamic>? body,
    String? authToken,
  }) async {
    final uri = Uri.parse('$_baseUrl$path');
    final headers = await _getHeaders(authToken: authToken);
    return _client.post(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> put(
    String path, {
    Map<String, dynamic>? body,
    String? authToken,
  }) async {
    final uri = Uri.parse('$_baseUrl$path');
    final headers = await _getHeaders(authToken: authToken);
    return _client.put(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(
    String path, {
    String? authToken,
  }) async {
    final uri = Uri.parse('$_baseUrl$path');
    final headers = await _getHeaders(authToken: authToken);
    return _client.delete(uri, headers: headers);
  }

  Future<http.Response> patch(
    String path, {
    Map<String, String>? queryParameters,
    String? authToken,
  }) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: queryParameters);
    final headers = await _getHeaders(authToken: authToken);
    return _client.patch(
      uri,
      headers: headers,
    );
  }

  void dispose() {
    _client.close();
  }
}
