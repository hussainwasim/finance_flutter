import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
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
