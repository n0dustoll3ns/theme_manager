import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

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
  String description;
  Color modifiedPackageColor = Colors.green;
  Color modifiedElementColor = Colors.yellow;
  Color crititcalColor = Colors.red;

  UserThemeConfig({
    required this.brightness,
    required this.primaryColor,
    required this.isImmutable,
    required this.fontSizeFactor,
    required this.name,
    required this.description,
  }) : iconColor = primaryColor;

  Map<String, dynamic> toJson() => {
        'isImmutable': isImmutable,
        'brightness': brightness.name.toString(),
        'primaryColor': primaryColor.value,
        'fontSizeFactor': fontSizeFactor,
        'iconColor': iconColor.value,
        'name': name,
        'description': description,
        'modifiedPackageColor': modifiedPackageColor.value,
        'modifiedElementColor': modifiedElementColor.value,
        'crititcalColor': crititcalColor.value,
      };

  UserThemeConfig.fromJson(Map<String, dynamic> json)
      : isImmutable = json['isImmutable'],
        brightness =
            json['brightness'] == 'light' ? Brightness.light : Brightness.dark,
        primaryColor = Color(json['primaryColor']),
        fontSizeFactor = json['fontSizeFactor'],
        iconColor = Color(json['iconColor']),
        name = json['name'],
        description = json['description'],
        modifiedPackageColor = Color(json['modifiedPackageColor']),
        modifiedElementColor = Color(json['modifiedElementColor']),
        crititcalColor = Color(json['crititcalColor']);
}

List<UserThemeConfig> defaultThemeConfigurations = [
  UserThemeConfig(
    isImmutable: true,
    brightness: Brightness.light,
    name: 'Light Theme',
    description: 'Description',
    primaryColor: Colors.blue,
    fontSizeFactor: 1,
  ),
  UserThemeConfig(
      isImmutable: true,
      brightness: Brightness.dark,
      name: 'Dark Theme',
      description: 'Description',
      primaryColor: Colors.red,
      fontSizeFactor: 1),
];

List<UserThemeConfig> decodeThemes(List<String> storageData) {
  return storageData
      .map((e) => UserThemeConfig.fromJson(jsonDecode(e)))
      .toList();
}

List<String> encodeThemes(List<UserThemeConfig> configurations) {
  return configurations.map((e) => jsonEncode(e.toJson())).toList();
}
