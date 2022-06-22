import 'package:flutter/material.dart';

const defaultPadding = 16.0;
const kDefaultBorderRadius = Radius.circular(4);
const lightColor = Colors.grey;

final BoxDecoration kDefaultBoxBorder = BoxDecoration(
  borderRadius: BorderRadius.circular(4),
  border: Border.all(color: lightColor, width: 0.7),
);

BoxDecoration kDefaultWindowTitleDecorationOf(BuildContext context) =>
    BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: const BorderRadius.only(
        topLeft: kDefaultBorderRadius,
        topRight: kDefaultBorderRadius,
      ),
    );

Color computedFontLuminanceFrom(BuildContext context) =>
    Theme.of(context).primaryColor.computeLuminance() > 0.38
        ? Colors.black
        : Colors.white;

Brightness computeBrightnessFromBackgroundColor(Color color) =>
    color.computeLuminance() > 0.5 ? Brightness.light:Brightness.dark;
