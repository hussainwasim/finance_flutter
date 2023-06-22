import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiMethods {
  static post(String url, Map<String, String> body) async {
    const storage = FlutterSecureStorage();
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    final jsonBody = jsonEncode(body);
    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonBody);
    return response;
  }

  static get(String url) async {
    const storage = FlutterSecureStorage();
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    var response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }
}
