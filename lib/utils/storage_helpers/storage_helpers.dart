import 'dart:developer';
import 'package:fin/utils/storage_helpers/storage_helpers_string.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageHelper {
  //? private storage object
  static late SharedPreferences? instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
    logAllData();
  }

  //? to print all the available data
  static void logAllData() {
    final keys = instance?.getKeys();
    for (final key in keys!) {
      log(
        "$key : ${instance?.get(key)}",
        name: " 📦 Storage 📦 ",
      );
    }
  }

  static Future<void> clearAllData() async {
    // CommonDialog.showLoadingDialog();
    await instance?.clear();
    // CommonDialog.cancelDialog();
    // Get.offAll(LoginScreen());
  }

  // static Future<bool> isPunchIn() async {
  //   final now = DateTime.now();
  //   final today = DateFormat('ddMMyyyy').format(now);
  //   if (instance.getString(StorageHelperString.isPunchInDate) == today &&
  //       instance.getBool(StorageHelperString.isPunchIn) == true) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // static Future<bool> isPunchOut() async {
  //   final now = DateTime.now();
  //   final today = DateFormat('ddMMyyyy').format(now);
  //   if (instance.getString(StorageHelperString.isPunchOutDate) == today &&
  //       instance.getBool(StorageHelperString.isPunchOut) == true) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // static Future<void> setPunchOut() async {
  //   final now = DateTime.now();
  //   final today = DateFormat('ddMMyyyy').format(now);
  //   await instance.setString(StorageHelperString.isPunchOutDate, today);
  //   await instance.setBool(StorageHelperString.isPunchOut, true);
  // }

  // static Future<void> setPunchIn() async {
  //   final now = DateTime.now();
  //   final today = DateFormat('ddMMyyyy').format(now);
  //   await instance.setString(StorageHelperString.isPunchInDate, today);
  //   await instance.setBool(StorageHelperString.isPunchIn, true);
  // }

  // static Future<void> clearPunchInOut() async {
  //   await instance.remove(StorageHelperString.isPunchInDate);
  //   await instance.remove(StorageHelperString.isPunchIn);
  //   await instance.remove(StorageHelperString.isPunchOutDate);
  //   await instance.remove(StorageHelperString.isPunchOut);
  // }
}
