import 'package:flutter/material.dart';
import 'dart:convert';
import '../styles.dart';
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
  Brightness get brightness =>
      computeBrightnessFromBackgroundColor(backgroundColor);
  Color primaryColor;
  Color backgroundColor;
  double fontSizeFactor;
  String name;
  Color modifiedPackageColor;
  Color modifiedElementColor;
  Color crititcalColor;

  UserThemeConfig({
    required this.primaryColor,
    required this.backgroundColor,
    required this.isImmutable,
    required this.fontSizeFactor,
    required this.name,
    required this.modifiedPackageColor,
    required this.modifiedElementColor,
    required this.crititcalColor,
  });

  Map<String, dynamic> toJson() => {
        'isImmutable': isImmutable,
        'backgroundColor': backgroundColor.toHex(),
        'primaryColor': primaryColor.toHex(),
        'fontSizeFactor': fontSizeFactor,
        'name': name,
        'modifiedPackageColor': modifiedPackageColor.toHex(),
        'modifiedElementColor': modifiedElementColor.toHex(),
        'crititcalColor': crititcalColor.toHex(),
      };

  UserThemeConfig.fromJson(Map<String, dynamic> json)
      : isImmutable = json['isImmutable'],
        primaryColor = HexColor.fromHex(json['primaryColor']),
        backgroundColor = HexColor.fromHex(json['backgroundColor']),
        fontSizeFactor = json['fontSizeFactor'],
        name = json['name'],
        modifiedPackageColor = HexColor.fromHex(json['modifiedPackageColor']),
        modifiedElementColor = HexColor.fromHex(json['modifiedElementColor']),
        crititcalColor = HexColor.fromHex(json['crititcalColor']);
}

List<UserThemeConfig> defaultThemeConfigurations = [
  UserThemeConfig(
    isImmutable: true,
    primaryColor: Colors.blue,
    backgroundColor: const Color(0xFFFAFAFA),
    name: 'Светлая тема',
    fontSizeFactor: 1,
    modifiedPackageColor: Colors.green,
    modifiedElementColor: Colors.yellow,
    crititcalColor: Colors.red,
  ),
  UserThemeConfig(
    isImmutable: true,
    primaryColor: Colors.red,
    backgroundColor: const Color(0xFF303030),
    name: 'Темная тема',
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
