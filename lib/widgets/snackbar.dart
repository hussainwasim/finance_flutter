import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(message),
        ),
      );

  static void showTopSnackBar(String message,
      {String title = 'Oops!', Color color = const Color(0xFFC20000)}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      colorText: Colors.white,
    );
  }

  static void showTopSnackSuccessBar(String message,
      {String title = 'Snap!', Color color = Colors.green}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      colorText: Colors.white,
    );
  }
}
