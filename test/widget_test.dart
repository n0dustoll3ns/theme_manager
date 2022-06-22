// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:themes_sandbox/UX/user_theme_config.dart';

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
      'primaryColor': "#ff2196f3",
      'fontSizeFactor': 1.0,
      'name': 'Светлая тема',
      'modifiedPackageColor': '#ff4caf50',
      'modifiedElementColor': '#ffffeb3b',
      'crititcalColor': '#fff44336'
    });
    Map<String, dynamic> darkConfigMap = {
      'isImmutable': true,
      'primaryColor': '#fff44336',
      'fontSizeFactor': 1.0,
      'name': 'Темная тема',
      'modifiedPackageColor': '#ff4caf50',
      'modifiedElementColor': '#ffffeb3b',
      'crititcalColor': '#fff44336'
    };
    var darkConfig = UserThemeConfig.fromJson(darkConfigMap);
    expect(darkConfig.isImmutable, true);
    expect(darkConfig.primaryColor.value, Colors.red.value);
    expect(darkConfig.fontSizeFactor, 1.0);
    expect(darkConfig.name, 'Темная тема');
    expect(darkConfig.modifiedPackageColor.value, Colors.green.value);
    expect(darkConfig.modifiedElementColor.value, Colors.yellow.value);
    expect(darkConfig.crititcalColor.value, Colors.red.value);
  });
}
