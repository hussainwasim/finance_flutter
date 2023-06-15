import 'package:fin/res/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    screenWidth = _mediaQueryData!.size.width;
    blockSizeVertical = screenHeight! / 100;
    blockSizeHorizontal = screenWidth! / 100;
  }
}

class MyTestStyle {
  static TextStyle headline1 = GoogleFonts.inter(
      textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: textwhite,
  ));
  static TextStyle address = GoogleFonts.inter(
      textStyle: const TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: primaryWhite,
  ));
  static TextStyle contactDetail = GoogleFonts.inter(
      textStyle: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: primaryWhite,
  ));

  static TextStyle headline2 = GoogleFonts.inter(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: primaryWhite,
  ));
  static TextStyle amount = GoogleFonts.inter(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 35,
    color: primaryWhite,
  ));

  static TextStyle subHeading = GoogleFonts.inter(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: textPrimary,
  ));
  static TextStyle cardTitle = GoogleFonts.inter(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Color(0xFF1A2131),
  ));

  static TextStyle bodytext2 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF000000),
  );
}
