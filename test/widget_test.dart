// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:themes_sandbox/UX/user_theme_config.dart';

import 'package:themes_sandbox/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('(de)serialazation', () {
    expect(defaultThemeConfigurations[0].toJson(), {
      'isImmutable': true,
      'brightness': 'light',
      'primaryColor': 4280391411,
      'fontSizeFactor': 1.0,
      'iconColor': 4280391411,
      'name': 'Светлая тема',
      'modifiedPackageColor': 4283215696,
      'modifiedElementColor': 4294961979,
      'crititcalColor': 4294198070
    });
    Map<String, dynamic> darkConfigMap = {
      'isImmutable': true,
      'brightness': 'dark',
      'primaryColor': Colors.red.value,
      'fontSizeFactor': 1.0,
      'iconColor': Colors.red.value,
      'name': 'Темная тема',
      'modifiedPackageColor': 4283215696,
      'modifiedElementColor': 4294961979,
      'crititcalColor': 4294198070
    };
    var darkConfig = UserThemeConfig.fromJson(darkConfigMap);
    expect(darkConfig.isImmutable, true);
    expect(darkConfig.brightness, Brightness.dark);
    expect(darkConfig.primaryColor.value, Colors.red.value);
    expect(darkConfig.fontSizeFactor, 1.0);
    expect(darkConfig.iconColor.value, Colors.red.value);
    expect(darkConfig.name, 'Темная тема');
    expect(darkConfig.modifiedPackageColor.value, Colors.green.value);
    expect(darkConfig.modifiedElementColor.value, Colors.yellow.value);
    expect(darkConfig.crititcalColor.value, Colors.red.value);
  });
}
