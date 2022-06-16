import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themes_sandbox/themes_dialog/components/additional_changes.dart';

import '../UX/user_theme_config.dart';
import '../provider/theme_provider.dart';
import '../styles.dart';
import 'components/brightness_picker.dart';
import 'components/color_picker_dialog.dart';
import 'components/font_size_picker.dart';
import 'components/theme_tile.dart';

class ThemeSettingsDialogWindow extends StatefulWidget {
  ThemeSettingsDialogWindow(
      {required this.beingChangedThemeIndex,
      required this.availableConfigurations})
      : super(key: UniqueKey());
  final int beingChangedThemeIndex;
  final List<UserThemeConfig> availableConfigurations;

  @override
  State<ThemeSettingsDialogWindow> createState() =>
      _ThemeSettingsDialogWindowState();
}

class _ThemeSettingsDialogWindowState extends State<ThemeSettingsDialogWindow> {
  late int _beingChangedThemeIndex;
  late Color pickerColor;
  late Color currentColor;
  List<UserThemeConfig> themesList = [];
  late Brightness currentBrightness;
  late double fontSizeFactor = 1;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    print('Инициализирую стейт диалога');
    themesList.addAll(widget.availableConfigurations);
    _beingChangedThemeIndex = widget.beingChangedThemeIndex;
    pickerColor = themesList[_beingChangedThemeIndex].primaryColor;
    currentColor = themesList[_beingChangedThemeIndex].primaryColor;
    currentBrightness = themesList[_beingChangedThemeIndex].brightness;
    fontSizeFactor = themesList[_beingChangedThemeIndex].fontSizeFactor;
  }

  @override
  Widget build(BuildContext context) {
    var current = themesList[_beingChangedThemeIndex];
    final activeButtonColor = !current.isImmutable
        ? Theme.of(context).iconTheme.color
        : const Color.fromARGB(128, 158, 158, 158);
    if (kDebugMode) {
      print(
          'При построении окна обнаружено ${themesList.sublist(2).length} Кастомных тем');
    }
    return AlertDialog(
      title: const Text('Theme Settings'),
      content: SizedBox(
        height: 420,
        width: 530,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 400,
              width: 250,
              decoration: kDefaultBoxBorder,
              margin: const EdgeInsets.all(4),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Available Themes'),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(4),
                        itemCount: themesList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == themesList.length
                              ? ListTile(
                                  title: MaterialButton(
                                    height: 25,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 19),
                                    onPressed: () => addNewConfig(index),
                                    child: Icon(Icons.add),
                                  ),
                                )
                              : ThemeTile(
                                  themeConfig: themesList[index],
                                  isBeingChanged:
                                      index == _beingChangedThemeIndex,
                                  configureThis: () {
                                    setState(() {
                                      _beingChangedThemeIndex = index;
                                      currentColor =
                                          themesList[index].primaryColor;
                                      currentBrightness =
                                          themesList[index].brightness;
                                      fontSizeFactor =
                                          themesList[index].fontSizeFactor;
                                    });
                                  },
                                  delete: () {
                                    themesList.removeAt(index);
                                    if (_beingChangedThemeIndex == index ||
                                        themesList.length - 1 <
                                            _beingChangedThemeIndex) {
                                      _beingChangedThemeIndex--;
                                    }
                                    setState(() {});
                                  },
                                );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: lightColor),
              ),
              margin: EdgeInsets.all(4),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Theme Configurator'),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(4),
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: currentColor,
                          ),
                          trailing: primaryColorSetter(
                              activeButtonColor!, current, context),
                          title: const Text('Primary color'),
                        ),
                        ListTile(
                          leading: Icon(
                            current.brightness == Brightness.light
                                ? Icons.brightness_5_rounded
                                : Icons.brightness_2_rounded,
                            color: currentColor,
                          ),
                          trailing: brightnessSetter(
                              activeButtonColor, current, context),
                          title: const Text('Background Color'),
                        ),
                        ListTile(
                          leading: Icon(Icons.sort_by_alpha,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          trailing: fontSizeSnippet(
                              activeButtonColor, current, context),
                          title: const Text('Font Size'),
                        ),
                        ListTile(
                          textColor: current.modifiedPackageColor,
                          leading: Icon(
                            Icons.abc,
                            color: current.modifiedPackageColor,
                          ),
                          trailing: beingModifiedPackageColorSnippet(
                              activeButtonColor, current, context),
                          title: const Text('Измененный пакет'),
                        ),
                        ListTile(
                          textColor: current.modifiedElementColor,
                          leading: Icon(
                            Icons.abc,
                            color: current.modifiedElementColor,
                          ),
                          trailing: beingModifiedElementColorSnippet(
                              activeButtonColor, current, context),
                          title: const Text('Что изменено'),
                        ),
                        ListTile(
                          textColor: current.crititcalColor,
                          leading: Icon(
                            Icons.abc,
                            color: current.crititcalColor,
                          ),
                          trailing: beingModifiedCriticalColorSnippet(
                              activeButtonColor, current, context),
                          title: const Text('Что изменено'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Отмена'),
          ),
        ),
        TextButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .refreshStoragedConfigurations(
                    themesList.sublist(2), _beingChangedThemeIndex);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Применить \nтему'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            print(
                'Пробую сохранить настройки. Кастомных тем: ${themesList.sublist(2).length}, выбранный индекс: $_beingChangedThemeIndex');
            Navigator.pop(
                context,
                AdditionalChanges(
                    newConfigList: themesList.sublist(2),
                    selectedOption: _beingChangedThemeIndex));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Применить \nи выйти',
            ),
          ),
        ),
      ],
    );
  }

  IconButton fontSizeSnippet(Color activeButtonColor, UserThemeConfig current,
          BuildContext context) =>
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.colorize, color: activeButtonColor),
        onPressed: current.isImmutable ? null : _showFontSizePickerDialog,
      );

  void _showFontSizePickerDialog() async {
    final selectedFontSize = await showDialog<double>(
      context: context,
      builder: (context) => FontSizePickerDialog(
          initialFontSizeFactor: fontSizeFactor.toDouble()),
    );
    if (selectedFontSize != null) {
      assert(selectedFontSize >= 0.5 && selectedFontSize <= 2);
      setState(() {
        fontSizeFactor = selectedFontSize;
        themesList[_beingChangedThemeIndex].fontSizeFactor = fontSizeFactor;
      });
    }
  }

  IconButton primaryColorSetter(Color activeButtonColor,
          UserThemeConfig current, BuildContext context) =>
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.colorize, color: activeButtonColor),
        onPressed: current.isImmutable ? null : _showPrimaryColorPickerDialog,
      );

  void _showPrimaryColorPickerDialog() async {
    final selectedColor = await showDialog<Color>(
      context: context,
      builder: (context) => ColorPickerDialog(
        intialColor: themesList[_beingChangedThemeIndex].primaryColor,
      ),
    );
    if (selectedColor != null) {
      setState(() {
        currentColor = selectedColor;
        themesList[_beingChangedThemeIndex].primaryColor = selectedColor;
      });
    }
  }

  IconButton brightnessSetter(Color activeButtonColor, UserThemeConfig current,
          BuildContext context) =>
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.colorize, color: activeButtonColor),
        onPressed: current.isImmutable ? null : _showBrightnessSetterDialog,
      );

  void _showBrightnessSetterDialog() async {
    final selectedBrightness = await showDialog<Brightness>(
      context: context,
      builder: (context) => BrightnessPickerDialog(
          initialBrightness: themesList[_beingChangedThemeIndex].brightness),
    );
    if (selectedBrightness != null) {
      setState(() {
        currentBrightness = selectedBrightness;
        themesList[_beingChangedThemeIndex].brightness = currentBrightness;
      });
    }
  }

  IconButton beingModifiedPackageColorSnippet(Color activeButtonColor,
          UserThemeConfig current, BuildContext context) =>
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.colorize, color: activeButtonColor),
        onPressed: current.isImmutable
            ? null
            : _showBeingModifiedPackageColorPickerDialog,
      );

  void _showBeingModifiedPackageColorPickerDialog() async {
    final selectedColor = await showDialog<Color>(
      context: context,
      builder: (context) => ColorPickerDialog(
        intialColor: themesList[_beingChangedThemeIndex].modifiedPackageColor,
      ),
    );
    if (selectedColor != null) {
      setState(() {
        themesList[_beingChangedThemeIndex].modifiedPackageColor =
            selectedColor;
      });
    }
  }

  IconButton beingModifiedCriticalColorSnippet(Color activeButtonColor,
          UserThemeConfig current, BuildContext context) =>
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.colorize, color: activeButtonColor),
        onPressed:
            current.isImmutable ? null : _showBeingModifiedCriticalColorSnippet,
      );

  void _showBeingModifiedCriticalColorSnippet() async {
    final selectedColor = await showDialog<Color>(
      context: context,
      builder: (context) => ColorPickerDialog(
        intialColor: themesList[_beingChangedThemeIndex].crititcalColor,
      ),
    );
    if (selectedColor != null) {
      setState(() {
        themesList[_beingChangedThemeIndex].crititcalColor = selectedColor;
      });
    }
  }

  IconButton beingModifiedElementColorSnippet(Color activeButtonColor,
          UserThemeConfig current, BuildContext context) =>
      IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(Icons.colorize, color: activeButtonColor),
        onPressed:
            current.isImmutable ? null : _showBeingModifiedElementColorSnippet,
      );

  void _showBeingModifiedElementColorSnippet() async {
    final selectedColor = await showDialog<Color>(
      context: context,
      builder: (context) => ColorPickerDialog(
        intialColor: themesList[_beingChangedThemeIndex].modifiedElementColor,
      ),
    );
    if (selectedColor != null) {
      setState(() {
        themesList[_beingChangedThemeIndex].modifiedElementColor =
            selectedColor;
      });
    }
  }

  void addNewConfig(int index) {
    print('Добавляю 1 новую тему в стейте диалогового окна');
    setState(() {
      _beingChangedThemeIndex = index;
      UserThemeConfig newConfig = UserThemeConfig(
        brightness: Theme.of(context).brightness,
        description: 'Описание',
        isImmutable: false,
        name: 'User Theme $index',
        primaryColor: currentColor,
        fontSizeFactor: fontSizeFactor,
      );
      themesList.add(newConfig);
    });
  }
}
