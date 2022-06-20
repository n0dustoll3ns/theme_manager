import 'package:flutter/material.dart';
import 'package:themes_sandbox/UX/user_theme_config.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    Key? key,
    required this.themeConfig,
    required this.isBeingChanged,
    required this.configureThis,
  }) : super(key: key);

  final bool isBeingChanged;
  final UserThemeConfig themeConfig;
  final VoidCallback configureThis;
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
        selected: isBeingChanged,
        leading: Icon(Icons.theater_comedy, color: themeConfig.iconColor),
        trailing: Icon(Icons.settings,
            color: themeConfig.isImmutable == false
                ? Theme.of(context).iconTheme.color
                : Color(0x809E9E9E)),
        title: Text(themeConfig.name),
        subtitle: Text(themeConfig.description));
  }
}
