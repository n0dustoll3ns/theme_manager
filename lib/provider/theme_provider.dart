import 'dart:convert';

import 'package:flutter/foundation.dart';
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
    print(
        'В хранилище найдено ${themesInStrorage.length} доступных кастомных темы');
    if (prefs.getStringList(keyOfOptionsList) != null) {
      _availableConfigurations.addAll(decodeThemes(themesInStrorage));
    }
    _selectedTheme = prefs.getInt(keyOfSelectedOption) ?? 0;
    print(
        'В хранилище обнаружен номер ${_selectedTheme} ранее примененной темы. Применяю его...');

    notifyListeners();
  }

  List<UserThemeConfig> get availableConfigurations => _availableConfigurations;
  int get currentThemeIndex => _selectedTheme;

  void refreshStoragedConfigurations(
      List<UserThemeConfig> configurations, int selectedOption) async {
    if (kDebugMode) {
      print(
          'Пользователь сохранил ${configurations.length} новых тем, складирую их в хранилище.');
    }
    _availableConfigurations = _availableConfigurations.sublist(0, 2);
    _availableConfigurations.addAll(configurations);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(keyOfOptionsList, encodeThemes(configurations));
    print(
        'Теперь в хранилище ${encodeThemes(configurations).length} доп тем. Всего провайдере доступно ${_availableConfigurations.length} тем');
    switchThemeTo(selectedOption);
  }

  void switchThemeTo(int selectedOption) async {
    print(
        'Применяю метод свитч провадйера. Новый индекс ${selectedOption}, всего доступно ${_availableConfigurations.length}. Устанавливаю этот номер в хранилище.');
    _selectedTheme = selectedOption;
    SharedPreferences.getInstance()
        .then((value) => value.setInt(keyOfSelectedOption, _selectedTheme));
    notifyListeners();
  }
}
