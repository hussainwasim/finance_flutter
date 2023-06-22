import 'dart:convert';

import 'package:fin/view/admin_dashbord/employee_list.dart';
import 'package:fin/view/view_model/apiMethod.dart';
import 'package:fin/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../login/login.dart';

class AddEmployeeModel {
  static saveEmployee(
    BuildContext context,
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
      'employee_name': name,
      'email': email,
      'mobile_no': mobileNo,
      'address': address,
      'password': password,
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
//Utils.showTopSnackSuccessBar("Employee Added Successfully...");
      return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeList(),
          ));
    } else if (response.statusCode == 400) {
      jsonResponse = response.body.toString();
      // Utils.showTopSnackBar("Try again");
      throw Exception("Error while fetching. \n ${response.body}");
    } else {
      throw Exception("Error while fetching. \n ${response.body}");
    }
  }
}
