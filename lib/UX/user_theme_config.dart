import 'package:flutter/material.dart';
import 'dart:convert';
import 'hex_to_string_converter.dart';

const List<Color> presetColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.grey,
  Colors.teal,
  Color.fromARGB(255, 233, 30, 99),
  Color(0xFF9C27B0),
];

class UserThemeConfig {
  final bool isImmutable;
  Brightness brightness;
  Color primaryColor;
  double fontSizeFactor;
  Color iconColor;
  String name;
  Color modifiedPackageColor;
  Color modifiedElementColor;
  Color crititcalColor;

  UserThemeConfig({
    required this.brightness,
    required this.primaryColor,
    required this.isImmutable,
    required this.fontSizeFactor,
    required this.name,
    required this.modifiedPackageColor,
    required this.modifiedElementColor,
    required this.crititcalColor,
  }) : iconColor = primaryColor;

  Map<String, dynamic> toJson() => {
        'isImmutable': isImmutable,
        'brightness': brightness.name.toString(),
        'primaryColor': primaryColor.toHex(),
        'fontSizeFactor': fontSizeFactor,
        'iconColor': iconColor.toHex(),
        'name': name,
        'modifiedPackageColor': modifiedPackageColor.toHex(),
        'modifiedElementColor': modifiedElementColor.toHex(),
        'crititcalColor': crititcalColor.toHex(),
      };

  UserThemeConfig.fromJson(Map<String, dynamic> json)
      : isImmutable = json['isImmutable'],
        brightness =
            json['brightness'] == 'light' ? Brightness.light : Brightness.dark,
        primaryColor = HexColor.fromHex(json['primaryColor']),
        fontSizeFactor = json['fontSizeFactor'],
        iconColor = HexColor.fromHex(json['iconColor']),
        name = json['name'],
        modifiedPackageColor = HexColor.fromHex(json['modifiedPackageColor']),
        modifiedElementColor = HexColor.fromHex(json['modifiedElementColor']),
        crititcalColor = HexColor.fromHex(json['crititcalColor']);
}

List<UserThemeConfig> defaultThemeConfigurations = [
  UserThemeConfig(
    isImmutable: true,
    brightness: Brightness.light,
    name: 'Светлая тема',
    primaryColor: Colors.blue,
    fontSizeFactor: 1,
    modifiedPackageColor: Colors.green,
    modifiedElementColor: Colors.yellow,
    crititcalColor: Colors.red,
  ),
  UserThemeConfig(
    isImmutable: true,
    brightness: Brightness.dark,
    name: 'Темная тема',
    primaryColor: Colors.red,
    fontSizeFactor: 1,
    modifiedPackageColor: Colors.green,
    modifiedElementColor: Colors.yellow,
    crititcalColor: Colors.red,
  ),
];

List<UserThemeConfig> decodeThemes(List<String> storageData) {
  return storageData
      .map((e) => UserThemeConfig.fromJson(jsonDecode(e)))
      .toList();
}

List<String> encodeThemes(List<UserThemeConfig> configurations) {
  return configurations.map((e) => jsonEncode(e.toJson())).toList();
}
