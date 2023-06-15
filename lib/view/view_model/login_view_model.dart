// import 'dart:convert';

// import 'package:fin/view/view_model/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../res/constant/api_response.dart';
// import '../../widgets/snackbar.dart';

// Future<ApiResponse> login(
//     String mobile, String password, BuildContext context) async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     final response = await http.post(
//         Uri.parse('http://product.artsify.in/public/api/signin'),
//         body: {'mobile_no': mobile, 'password': password},
//         headers: {'accept': 'application/json'});
//     if (response.statusCode == 200) {
//       apiResponse = User.fromJson(jsonDecode(response.body)) as ApiResponse;
//     } else if (response.statusCode == 422) {
//       Utils.showSnackBar(context, apiResponse.toString());
//       Utils.showSnackBar(context, 'Invalid');
//     }
//   } catch (e) {
//     //apiResponse.printError(info: "sever error");
//   }
//   return apiResponse;
// }

// //get token
// Future<String> getToken() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getString('token') ?? '';
// }

// //get User Id
// Future<int> getUserId() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getInt('id') ?? 0;
// }

// //get User Id
// Future<bool> logout() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.remove('token');
// }
