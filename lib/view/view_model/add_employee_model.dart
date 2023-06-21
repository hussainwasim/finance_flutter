import 'dart:convert';

import 'package:fin/view/view_model/apiMethod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AddEmployeeModel {
  static saveEmployee(
    name,
    email,
    mobileNo,
    address,
    password,
  ) async {
    const storage = FlutterSecureStorage();
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    // Map? desiredMap;
    late var response;

    Map<String, String> body = {
      'employee_name': 'abdc',
      'email': 'abcda@gmail.com',
      'mobile_no': '987406312',
      'address': 'dubai xmain road',
      'password': '1234567x8',
    };
    // if (empProfileFile != null) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('profile_url', empProfileFile));
    // }
    String jsonResponse;
    var url = "http://product.artsify.in/public/api/employees";
    response = await ApiMethods.post(url, body);
    if (response.statusCode == 200) {
      jsonResponse = response.body.toString();
      Map notificationResult = jsonDecode(jsonResponse.toString());
      return response = notificationResult;
    } else if (response.statusCode == 400) {
      jsonResponse = response.body.toString();
      throw Exception("Error while fetching. \n ${response.body}");
    } else {
      throw Exception("Error while fetching. \n ${response.body}");
    }
  }
}
