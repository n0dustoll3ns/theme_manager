import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../UX/user_theme_config.dart';
import '../keys.dart';

class ThemeProvider with ChangeNotifier {
  int _selectedTheme = 0;
  List<UserThemeConfig> _availableConfigurations = defaultThemeConfigurations;
  ThemeProvider.fromStorage() {
    loadState();
  }

  loadState() async {
    final String defaultThemesEncoded =
        await rootBundle.loadString('customthemes.json');
    List<dynamic> defaultThemesUnpacked = [];
    try {
      defaultThemesUnpacked = jsonDecode(defaultThemesEncoded)["themes"];
      _availableConfigurations.clear();
      List<UserThemeConfig> defaultThemes = defaultThemesUnpacked
          .map((e) => UserThemeConfig.fromJson(e))
          .toList();
      _availableConfigurations.addAll(defaultThemes);
    } finally {
      _availableConfigurations = defaultThemeConfigurations;
    }

    var prefs = await SharedPreferences.getInstance();
    var themesInStrorage = prefs.getStringList(keyOfOptionsList) ?? [];
    _selectedTheme = prefs.getInt(keyOfSelectedOption) ?? 0;
    if (prefs.getStringList(keyOfOptionsList) != null) {
      _availableConfigurations.addAll(decodeThemes(themesInStrorage));
    }
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
  }

  void switchThemeTo(int selectedOption) async {
    _selectedTheme = selectedOption;
    SharedPreferences.getInstance()
        .then((value) => value.setInt(keyOfSelectedOption, _selectedTheme));
    notifyListeners();
  }

  

}
