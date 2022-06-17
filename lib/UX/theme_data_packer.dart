import 'package:flutter/material.dart';
import 'material_colors.dart';
import 'text_theme.dart';
import 'user_theme_config.dart';

ThemeData buildThemeData(
  UserThemeConfig selectedConfig,
) {
  return ThemeData(
    brightness: selectedConfig.brightness,
    primaryColor: selectedConfig.primaryColor,
    primarySwatch:
        AppColors.getMaterialColorFromColor(selectedConfig.primaryColor),
    buttonTheme: ButtonThemeData(buttonColor: selectedConfig.primaryColor),
    primaryIconTheme: IconThemeData(
      color: selectedConfig.primaryColor,
    ),
    textTheme:
        AppFontSizes.getTextThemeWithFontSize(selectedConfig.fontSizeFactor),
    // listTileTheme: ListTileThemeData(),
  );
}
