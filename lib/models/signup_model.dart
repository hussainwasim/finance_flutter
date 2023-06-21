import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../view/login/login.dart';

class SignUpModel {
  static sign(name, mobile, password, BuildContext context) async {
    const storage = FlutterSecureStorage();
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    Map<String, String> body = {
      "name": name,
      "mobile_no": mobile,
      "password": password,
    };
    final jsonBody = jsonEncode(body);
    String jsonResponse;
    // var url = baseUrl + '/customers/';
    Uri url = Uri.parse("https://product.artsify.in/public/api/signup/");
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    // var response = await BaseClient.post(url, body);
    var response = await http.post(url, body: jsonBody, headers: headers);

    if (response.statusCode == 200) {
      jsonResponse = response.body.toString();
      Map notificationResult = jsonDecode(jsonResponse.toString());

      return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LogIn(),
          )); //response = notificationResult as http.Response;
    } else if (response.statusCode == 400) {
      jsonResponse = response.body.toString();
      throw Exception("Error while fetching. \n ${response.body}");
    } else {
      throw Exception("Error while fetching. \n ${response.body}");
    }
  }
}
