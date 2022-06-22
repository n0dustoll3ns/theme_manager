import 'package:flutter/material.dart';
import 'material_colors.dart';
import 'text_theme.dart';
import 'user_theme_config.dart';

ThemeData buildThemeData(
  UserThemeConfig selectedConfig,
) {
  return ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(elevation: 5),
    ),
    scaffoldBackgroundColor: selectedConfig.backgroundColor,
    drawerTheme:
        DrawerThemeData(backgroundColor: selectedConfig.backgroundColor),
    dialogBackgroundColor: selectedConfig.backgroundColor,
    brightness: selectedConfig.brightness,
    primaryColor: selectedConfig.primaryColor,
    cardColor: selectedConfig.backgroundColor,
    primarySwatch:
        AppColors.getMaterialColorFromColor(selectedConfig.primaryColor),
    buttonTheme: ButtonThemeData(buttonColor: selectedConfig.primaryColor),
    primaryIconTheme: IconThemeData(
      color: selectedConfig.primaryColor,
    ),
    textTheme:
        AppFontSizes.getTextThemeWithFontSize(selectedConfig.fontSizeFactor),
  );
}
