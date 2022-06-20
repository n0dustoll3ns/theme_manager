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
