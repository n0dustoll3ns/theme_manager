import 'package:flutter/material.dart';
import 'user_theme_config.dart';

class AppFontSizes {
  // static List<Color> primaryColors = presetColors;

  static TextTheme getTextThemeWithFontSize(double fontSizeFactor) {
    return TextTheme(
      displayLarge: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: 112.0 * fontSizeFactor,
          fontWeight: FontWeight.w100,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      displayMedium: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: 56.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      displaySmall: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: 45.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      headlineLarge: TextStyle(
          // inherit: false,
          //  color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: 40.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      headlineMedium: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: 34.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      headlineSmall: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: 24.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      titleLarge: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: 20.0 * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      titleMedium: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: 16.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      titleSmall: TextStyle(
          // inherit: false,
          // color: Color(0xff000000),
          // fontFamily: 'Segoe UI',
          fontSize: 14.0 * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: 0.1,
          decoration: TextDecoration.none),
      bodyLarge: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: 14.0 * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      bodyMedium: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: 14.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      bodySmall: TextStyle(
          // inherit: false,
          // color: Color(0x8a000000),
          // fontFamily: 'Segoe UI',
          fontSize: 12.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      labelLarge: TextStyle(
          // inherit: false,
          // color: Color(0xdd000000),
          // fontFamily: 'Segoe UI',
          fontSize: 14.0 * fontSizeFactor,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      labelMedium: TextStyle(
          // inherit: false,
          // color: Color(0xff000000),
          // fontFamily: 'Segoe UI',
          fontSize: 12.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          decoration: TextDecoration.none),
      labelSmall: TextStyle(
          // inherit: false,
          // color: Color(0xff000000),
          // fontFamily: 'Segoe UI',
          fontSize: 10.0 * fontSizeFactor,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: 1.5,
          decoration: TextDecoration.none),
    );
  }
}
