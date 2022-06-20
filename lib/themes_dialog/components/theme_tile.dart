import 'package:flutter/material.dart';
import 'package:themes_sandbox/UX/user_theme_config.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({
    Key? key,
    required this.themeConfig,
    required this.isBeingChanged,
    required this.configureThis,
    required this.delete,
    required this.focusNode,
    required this.rename,
    required this.isRenamingNow,
    required this.renamingTextController,
    required this.beginRenaming,
  }) : super(key: key);

  final bool isBeingChanged;
  final UserThemeConfig themeConfig;
  final VoidCallback configureThis;
  final VoidCallback delete;
  final FocusNode focusNode;
  final bool isRenamingNow;
  final TextEditingController renamingTextController;
  final Function(String) rename;
  final VoidCallback beginRenaming;

  @override
  Widget build(BuildContext context) {
    final buttonColor = themeConfig.isImmutable == false
        ? Theme.of(context).iconTheme.color
        : const Color(0x809E9E9E);
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Container(
        color: isBeingChanged ? Colors.grey.withOpacity(0.5) : null,
        height: 34,
        child: TextButton(
          onLongPress: beginRenaming,
          onPressed: configureThis,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: isRenamingNow
                    ? TextField(
                        focusNode: focusNode,
                        autofocus: true,
                        onEditingComplete: () {
                          rename(renamingTextController.text);
                        },
                        controller: renamingTextController)
                    : Text(
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
    );
  }
}
