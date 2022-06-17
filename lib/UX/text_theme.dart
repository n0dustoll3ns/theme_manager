import 'package:flutter/material.dart';
import 'user_theme_config.dart';

const systemFontSizes = [
  112.0,
  56.0,
  45.0,
  40.0,
  34.0,
  24.0,
  20.0,
  16.0,
  14.0,
  14.0,
  14.0,
  12.0,
  14.0,
  12.0,
  10.0,
];

var defaultFontSizes = systemFontSizes.map((e) => e * 0.8).toList();

class AppFontSizes {
  // static List<Color> primaryColors = presetColors;

  static TextTheme getTextThemeWithFontSize(double fontSizeFactor) {
    return TextTheme(
      displayLarge: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[0] * fontSizeFactor,
          fontWeight: FontWeight.w100,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      displayMedium: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[1] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      displaySmall: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[2] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      headlineLarge: TextStyle(
          // inherit: false,
          //  color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[3] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      headlineMedium: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[4] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      headlineSmall: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[5] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      titleLarge: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[6] * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      titleMedium: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[7] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      titleSmall: TextStyle(
          // inherit: false,
          // color: Color(0xff000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[8] * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: 0.1,
          decoration: TextDecoration.none),
      bodyLarge: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[9] * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      bodyMedium: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[10] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      bodySmall: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[11] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      labelLarge: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[12] * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      labelMedium: TextStyle(
          // inherit: false,
          // color: Color(0xff000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[13] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      labelSmall: TextStyle(
          // inherit: false,
          // color: Color(0xff000000),
          // fontFamily: 'Segoe UI',
          fontSize: defaultFontSizes[14] * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: 1.5,
          decoration: TextDecoration.none),
    );
  }
}
