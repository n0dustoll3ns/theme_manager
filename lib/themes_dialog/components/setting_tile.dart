import 'package:flutter/material.dart';

import '../../staff_data/user_theme_config.dart';

class SettingTile<T> extends StatelessWidget {
  final String settingName;
  final UserThemeConfig currentConfig;
  final T value;
  final Widget valueIcon;
  final VoidCallback showDialogCallback;

  const SettingTile({
    Key? key,
    required this.settingName,
    required this.currentConfig,
    required this.value,
    required this.showDialogCallback,
    required this.valueIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: currentConfig.isImmutable ? null : showDialogCallback,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: SizedBox(
          height: 34,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(settingName),
              )),
              AspectRatio(
                aspectRatio: 1,
                child: Center(child: valueIcon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
