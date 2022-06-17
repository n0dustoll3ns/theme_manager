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
    return SizedBox(
      height: 34,
      child: Card(
        elevation: 0,
        child: Container(
          color: isBeingChanged ? Colors.grey.withOpacity(0.5) : null,
          child: TextButton(
            onPressed: configureThis,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    themeConfig.name,
                    style: TextStyle(color: themeConfig.primaryColor),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: Theme.of(context).iconTheme.size ?? 24 * 0.8,
                  onPressed: themeConfig.isImmutable ? null : delete,
                  icon: themeConfig.isImmutable
                      ? const Icon(Icons.lock)
                      : const Icon(Icons.delete),
                  color: buttonColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
