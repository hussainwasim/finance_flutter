import 'dart:convert';

import 'package:fin/view/view_model/apiMethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../view/login/login.dart';
import '../widgets/snackbar.dart';

class SignUpModel {
  static sign(
      name, mobile, password, confirmPassword, BuildContext context) async {
    const storage = FlutterSecureStorage();
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    Map<String, String> body = {
      "name": name,
      "mobile_no": mobile,
      "password": password,
      "password_confirmation": confirmPassword,
    };
    final jsonBody = jsonEncode(body);
    String jsonResponse;
    // var url = baseUrl + '/customers/';
    var url = "https://product.artsify.in/public/api/signup";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    // var response = await BaseClient.post(url, body);
    var response = await ApiMethods.post(url, body);

    if (response.statusCode == 200) {
      jsonResponse = response.body.toString();
      Map notificationResult = jsonDecode(jsonResponse.toString());
      // Utils.showTopSnackSuccessBar('User Registered  successfully ',
      //     title: 'Success', color: Colors.green);
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
