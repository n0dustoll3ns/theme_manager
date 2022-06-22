import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../keys.dart';
import '../staff_data/user_theme_config.dart';

class ThemeProvider with ChangeNotifier {
  int _selectedTheme = 0;
  // ignore: prefer_final_fields
  Map<String, String> _settingNames = {
    settingKeys[0]:
        "Главный цвет темы",
    settingKeys[1]: "Цвет фона",
    settingKeys[2]: "Размер шрифтов",
    settingKeys[3]: "Измененный пакет",
    settingKeys[4]:
        "Измененный элемент",
    settingKeys[5]:
        "Цвет критической ошибки"
  };
  List<UserThemeConfig> _availableConfigurations = defaultThemeConfigurations;
  Map<String, String> get settingNames => _settingNames;
  ThemeProvider.fromStorage() {
    loadState();
  }

  loadSettingNamesFromJson() async {
    final String settingNamesEncoded =
        await rootBundle.loadString('settings.json');
    List<dynamic> settingNamesUnpackedList =
        jsonDecode(settingNamesEncoded)["settings"];
    Map<String, String> settingNamesUnpackedMap = {};
    for (var element in settingNamesUnpackedList) {
      settingNamesUnpackedMap.addAll({element[0]: element[1]});
    }
    _settingNames.forEach((key, value) {
      if (settingNamesUnpackedMap.containsKey(key)) {
        _settingNames[key] = settingNamesUnpackedMap[key]!;
      }
    });
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
    loadSettingNamesFromJson();
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
