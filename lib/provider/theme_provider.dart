import 'package:flutter/material.dart';
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
  }

  void switchThemeTo(int selectedOption) async {
    _selectedTheme = selectedOption;
    SharedPreferences.getInstance()
        .then((value) => value.setInt(keyOfSelectedOption, _selectedTheme));
    notifyListeners();
  }
}
