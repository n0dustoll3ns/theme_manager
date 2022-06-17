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
import 'components/width_alert.dart';

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

    return (MediaQuery.of(context).size.width < 660 ||
            MediaQuery.of(context).size.height < 660)
        ? const ViewPortWidthAlertDialog()
        : AlertDialog(
            title: const Center(child: Text('Конфигуратор тем')),
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
                          child: Text('Список доступных тем'),
                        ),
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: themesList.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                return index == themesList.length
                                    ? TextButton(
                                        onPressed: () => addNewConfig(index),
                                        child: Icon(Icons.add,
                                            color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .color ??
                                                Colors.grey),
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
                                            fontSizeFactor = themesList[index]
                                                .fontSizeFactor;
                                          });
                                        },
                                        delete: () {
                                          themesList.removeAt(index);
                                          if (_beingChangedThemeIndex ==
                                                  index ||
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
                    decoration: kDefaultBoxBorder,
                    margin: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Настройки выделенной темы'),
                        ),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(4),
                            children: [
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: SizedBox(
                                  height: 34,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Основной цвет'),
                                      )),
                                      IconButton(
                                        hoverColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        iconSize:
                                            Theme.of(context).iconTheme.size ??
                                                24 * 0.8,
                                        onPressed: current.isImmutable
                                            ? null
                                            : _showPrimaryColorPickerDialog,
                                        icon: Icon(Icons.circle,
                                            color: currentColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: SizedBox(
                                  height: 34,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Цвет фона'),
                                      )),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize:
                                            Theme.of(context).iconTheme.size ??
                                                24 * 0.8,
                                        onPressed: current.isImmutable
                                            ? null
                                            : _showBrightnessSetterDialog,
                                        icon: Icon(
                                          current.brightness == Brightness.light
                                              ? Icons.brightness_5_rounded
                                              : Icons.brightness_2_rounded,
                                          color: currentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: SizedBox(
                                  height: 34,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Размер шрифтов'),
                                      )),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize:
                                            Theme.of(context).iconTheme.size ??
                                                24 * 0.8,
                                        onPressed: current.isImmutable
                                            ? null
                                            : _showFontSizePickerDialog,
                                        icon: Icon(Icons.sort_by_alpha,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: SizedBox(
                                  height: 34,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Измененный пакет'),
                                      )),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize:
                                            Theme.of(context).iconTheme.size ??
                                                24 * 0.8,
                                        onPressed: current.isImmutable
                                            ? null
                                            : _showBeingModifiedPackageColorPickerDialog,
                                        icon: Icon(
                                          Icons.abc,
                                          color: current.modifiedPackageColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: SizedBox(
                                  height: 34,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Измененный элемент'),
                                      )),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize:
                                            Theme.of(context).iconTheme.size ??
                                                24 * 0.8,
                                        onPressed: current.isImmutable
                                            ? null
                                            : _showBeingModifiedElementColorSnippet,
                                        icon: Icon(
                                          Icons.abc,
                                          color: current.modifiedElementColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: SizedBox(
                                  height: 34,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text('Цвет критической ошибки'),
                                      )),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize:
                                            Theme.of(context).iconTheme.size ??
                                                24 * 0.8,
                                        onPressed: current.isImmutable
                                            ? null
                                            : _showBeingModifiedCriticalColorSnippet,
                                        icon: Icon(
                                          Icons.abc,
                                          color: current.crititcalColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                  child: const Text('Назад'),
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
                  Navigator.pop(
                      context,
                      AdditionalChanges(
                          newConfigList: themesList.sublist(2),
                          selectedOption: _beingChangedThemeIndex));
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
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
    var currentTheme = themesList[_beingChangedThemeIndex];
    setState(() {
      _beingChangedThemeIndex = index;
      UserThemeConfig newConfig = UserThemeConfig(
        brightness: currentTheme.brightness,
        description: 'Описание',
        isImmutable: false,
        name: 'Настраиваемая тема $index',
        primaryColor: currentColor,
        fontSizeFactor: fontSizeFactor,
        modifiedPackageColor: currentTheme.modifiedPackageColor,
        modifiedElementColor: currentTheme.modifiedElementColor,
        crititcalColor: currentTheme.crititcalColor,
      );
      themesList.add(newConfig);
    });
  }
}
