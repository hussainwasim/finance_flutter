import 'package:flutter/material.dart';

class MyValidators {
  static String? ValidateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    } else if (!regex.hasMatch(value)) {
      return "Enter Valid Email";
    } else {
      return null;
    }
  }

  static String? ValidateContact(String? value, String? fieldName) {
    RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
    if (value == null || value.isEmpty) {
      return "Enter Your $fieldName";
    } else if (!regex.hasMatch(value)) {
      return "Enter Valid $fieldName";
    } else {
      return null;
    }
  }

  static String? validateEmptyFileds(String? value, String? fieldName) {
    if (value == null || value.isEmpty || value == '') {
      return 'Enter Your $fieldName';
    } else {
      return null;
    }
  }
}
