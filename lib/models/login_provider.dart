import 'dart:convert';

import 'package:fin/models/BaseClients.dart';
import 'package:fin/view/admin_dashbord/admin_dashboard.dart';
import 'package:fin/view/driver_dashbord/driver_dashboard.dart';
import 'package:fin/view/view_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/storage_helpers/storage_helpers.dart';
import '../utils/storage_helpers/storage_helpers_string.dart';
import '../widgets/snackbar.dart';

class LoginProviderModel with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    setLoading(true);
    if (mobileController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse('http://product.artsify.in/public/api/signin'),
          body: ({
            'mobile_no': mobileController.text,
            'password': passwordController.text,
          }));
      if (response.statusCode == 200) {
        String resBody = response.body.toString();

        Map resBodyMap = jsonDecode(resBody);

        if (resBodyMap['data'] != "") {
          LoginResponseData loginResponseData =
              loginResponseDataFromJson(response.body);
          await _storage.write(key: 'LOGIN_RES', value: jsonEncode(resBodyMap));
          await _storage.write(
              key: 'LOGIN_RESS', value: resBodyMap['data']['token'].toString());
          await _storage.write(
              key: 'User_Id', value: resBodyMap['user']['id'].toString());
          await StorageHelper.instance.setString(
              StorageHelperString.loginUserData,
              json.encode(loginResponseData.toJson()));
          await StorageHelper.instance.setInt(StorageHelperString.loginUserType,
              loginResponseData.user?.role ?? 3);
          await StorageHelper.instance
              .setBool(StorageHelperString.isUserLoggedIn, true);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => loginResponseData.user?.role == 0
                  ? const AdminDashboard()
                  : const DriverDashboard(),
            ),
            (route) => false,
          );
        } else {
          Utils.showSnackBar(context, resBodyMap['message'].toString());
          Utils.showSnackBar(context, 'Invalid');
        }
        setLoading(false);
      } else {
        String resBody = response.body.toString();

        Map resBodyMap = jsonDecode(resBody);

        setLoading(false);
        Utils.showTopSnackBar(resBodyMap["messages"]);
      }
    }
  }
}
