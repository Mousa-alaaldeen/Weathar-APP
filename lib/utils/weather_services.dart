import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<http.Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    Map<String, String>? data,
  }) async {
    final uri = Uri.parse(url);

    return await http.get(
      uri,
    );
  }

  static Future<http.Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    final uri = Uri.parse(url).replace(queryParameters: query);

    return await http.post(
      uri,
      headers: headers,
      body: json.encode(data),
    );
  }

  static Future<http.Response> putData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    Map<String, String>? data,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    final uri = Uri.parse(url).replace(queryParameters: query);

    return await http.put(
      uri,
      headers: headers,
      body: json.encode(data),
    );
  }

  static Future<http.Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    Map<String, String>? data,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    final uri = Uri.parse(url).replace(queryParameters: query);

    return await http.delete(
      uri,
      headers: headers,
      body: json.encode(data),
    );
  }
}
