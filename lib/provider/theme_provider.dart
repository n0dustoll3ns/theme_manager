import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themes_sandbox/UX/hex_to_string_converter.dart';
import '../UX/user_theme_config.dart';
import '../keys.dart';

class ThemeProvider with ChangeNotifier {
  int _selectedTheme = 0;
  List<UserThemeConfig> _availableConfigurations = defaultThemeConfigurations;
  ThemeProvider.fromStorage() {
    loadState();
  }

  loadState() async {
    // var defaultThemes =
    //     (await rootBundle.loadString('assets/customthemes.json'));

    var prefs = await SharedPreferences.getInstance();
    var themesInStrorage = prefs.getStringList(keyOfOptionsList) ?? [];
    if (prefs.getStringList(keyOfOptionsList) != null) {
      _availableConfigurations.addAll(decodeThemes(themesInStrorage));
    }
    _selectedTheme = prefs.getInt(keyOfSelectedOption) ?? 0;
    notifyListeners();
  }

  List<UserThemeConfig> get availableConfigurations => _availableConfigurations;
  int get currentThemeIndex => _selectedTheme;

  void refreshStoragedConfigurations(
      List<UserThemeConfig> configurations, int selectedOption) async {
    _availableConfigurations = _availableConfigurations.sublist(0, 2);
    _availableConfigurations.addAll(configurations);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(keyOfOptionsList, encodeThemes(configurations));
    switchThemeTo(selectedOption);
    // var defaultThemes =
    //     (await rootBundle.loadString('assets/customthemes.json'));

  }

  void switchThemeTo(int selectedOption) async {
    _selectedTheme = selectedOption;
    SharedPreferences.getInstance()
        .then((value) => value.setInt(keyOfSelectedOption, _selectedTheme));
    notifyListeners();
  }
}
