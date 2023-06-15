import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://product.artsify.in/public/api';

class BaseClient {
  static const storage = FlutterSecureStorage();
  static post(String url, Map<String, String> body) async {
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    Map<String, String> headers = {
      'ContentType': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    final jsonBody = jsonEncode(body);
    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonBody);
    return response;
  }

  // static get(String url, Map<String, String> body,
  //     {required Map<String, String> headers, required String url}) async {
  //   Map<String, String> headers = {'ContentType': 'application/json'};

  //   var response = await http.get(Uri.parse(url), headers: headers);
  //   return response;
  // }
}
