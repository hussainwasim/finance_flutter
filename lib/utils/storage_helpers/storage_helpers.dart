import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

/// Use strings to read and write for objects
///
/// You can use json.encode()/json.decode() method
///
/// for ex:
/// ``` dart
/// final stringNameList = json.encode([“x”, “y”, “z”]);
/// final nameList = json.decode(stringNameList);
/// ```
abstract class StorageHelper {
  //? private storage object
  static late final SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
    logAllData();
  }

  //? to print all the available data
  static void logAllData() {
    final keys = instance.getKeys();
    for (final key in keys) {
      log(
        "$key : ${instance.get(key)}",
        name: " 📦 Storage 📦 ",
      );
    }
  }

  static Future<void> clearAllData() async {
    // CommonDialog.showLoadingDialog();
    await instance.clear();
    // CommonDialog.cancelDialog();
    // Get.offAll(LoginScreen());
  }
}
