import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themes_sandbox/provider/theme_provider.dart';

import '../themes_dialog/components/additional_changes.dart';
import '../themes_dialog/dialog.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: FlutterLogo(),
          ),
          const Center(
            child: Text(
              "Какое-нибудь меню",
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => showDialog<FinalChanges>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) {
                      return ThemeSettingsDialogWindow(
                        beingChangedThemeIndex: themeProvider.currentThemeIndex,
                        availableConfigurations:
                            themeProvider.availableConfigurations,
                        settingNames: themeProvider.settingNames,
                      );
                    })).then((userChanges) {
              if (userChanges != null) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .refreshStoragedConfigurations(
                        userChanges.newConfigList, userChanges.selectedOption);
              }
            }),
            child: const Text('Конфигуратор тем'),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
