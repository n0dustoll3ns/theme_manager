import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:themes_sandbox/UX/user_theme_config.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({
    Key? key,
    required this.themeConfig,
    required this.isBeingChanged,
    required this.configureThis,
    required this.delete,
  }) : super(key: key);

  final bool isBeingChanged;
  final UserThemeConfig themeConfig;
  final VoidCallback configureThis;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    final buttonColor = themeConfig.isImmutable == false
        ? Theme.of(context).iconTheme.color
        : const Color(0x809E9E9E);
    return ListTile(
      tileColor: isBeingChanged ? Colors.grey.withOpacity(0.5) : null,
      onTap: configureThis,
      leading: Icon(Icons.theater_comedy, color: themeConfig.primaryColor),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          themeConfig.isImmutable
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: delete,
                  icon: const Icon(Icons.delete),
                  color: buttonColor),
          Icon(Icons.settings, color: buttonColor),
        ],
      ),
      title: Text(
        themeConfig.name,
        style: TextStyle(color: themeConfig.primaryColor),
      ),
    );
  }
}
