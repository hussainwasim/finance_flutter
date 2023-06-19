import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AddEmployeeModel {
  static saveEmployee(
    name,
    mobileNo,
    email,
    address,
    password,
  ) async {
    const storage = FlutterSecureStorage();
    var loginResponse = await storage.read(key: 'LOGIN_RESS');
    Map? desiredMap;
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginResponse'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://product.artsify.in/public/api/employees'));
    request.fields.addAll({
      'employee_name': name.toString(),
      'email': email.toString(),
      'mobile_no': address.toString(),
      'password': password.toString(),
      'address': address.toString()
    });
    // if (empProfileFile != null) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('profile_url', empProfileFile));
    // }
    request.headers.addAll(headers);
    print("request:${request.fields}");
    http.StreamedResponse response = await request.send();
    print("response:${response.statusCode}");
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
