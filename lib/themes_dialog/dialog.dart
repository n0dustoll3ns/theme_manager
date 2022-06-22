import 'package:flutter/material.dart';
import 'package:themes_sandbox/themes_dialog/components/additional_changes.dart';

import '../UX/user_theme_config.dart';
import '../styles.dart';
import 'components/brightness_picker.dart';
import 'components/color_picker_dialog.dart';
import 'components/font_size_picker.dart';
import 'components/setting_tile.dart';
import 'components/theme_tile.dart';
import 'components/viewport_size_alert.dart';

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
  late bool _isBeingRenamed;
  FocusNode focusNode = FocusNode(
    onKeyEvent: (node, event) {
      return KeyEventResult.skipRemainingHandlers;
    },
  );
  late TextEditingController renamingTextController;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void rename(String newName) {
    setState(() {
      _isBeingRenamed = false;
      themesList[_beingChangedThemeIndex].name = renamingTextController.text;
    });
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
    renamingTextController =
        TextEditingController(text: themesList[_beingChangedThemeIndex].name);
    _isBeingRenamed = false;
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          _isBeingRenamed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var current = themesList[_beingChangedThemeIndex];

    return (MediaQuery.of(context).size.width < 660 ||
            MediaQuery.of(context).size.height < 660)
        ? const ViewportSizeAlertDialog()
        : AlertDialog(
            actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            actionsAlignment: MainAxisAlignment.start,
            titlePadding: EdgeInsets.zero,
            title: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: kDefaultWindowTitleDecorationOf(context),
                child: Center(
                    child: Text(
                  'Конфигуратор тем',
                  style: TextStyle(color: computedFontLuminanceFrom(context)),
                ))),
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
                    child: leftColumn(),
                  ),
                  Container(
                    height: 400,
                    width: 250,
                    decoration: kDefaultBoxBorder,
                    margin: const EdgeInsets.all(4),
                    child: rightColumn(current, context),
                  ),
                ],
              ),
            ),
            actions: actions(),
          );
  }

  Column leftColumn() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Список доступных тем'),
        ),
        Expanded(
          child: ListView.builder(
            controller: ScrollController(),
            padding: EdgeInsets.zero,
            itemCount: themesList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index == themesList.length
                  ? TextButton(
                      onPressed: () => addNewConfig(index),
                      child: Icon(Icons.add,
                          color:
                              Theme.of(context).textTheme.bodyMedium!.color ??
                                  Colors.grey),
                    )
                  : ThemeTile(
                      themeConfig: themesList[index],
                      isBeingChanged: index == _beingChangedThemeIndex,
                      configureThis: () {
                        setState(() {
                          _beingChangedThemeIndex = index;
                          currentColor = themesList[index].primaryColor;
                          currentBrightness = themesList[index].brightness;
                          fontSizeFactor = themesList[index].fontSizeFactor;
                          renamingTextController.text = themesList[index].name;
                        });
                      },
                      delete: () {
                        themesList.removeAt(index);
                        if (_beingChangedThemeIndex == index ||
                            themesList.length - 1 < _beingChangedThemeIndex) {
                          _beingChangedThemeIndex--;
                        }
                        setState(() {});
                      },
                      focusNode: focusNode,
                      rename: (String newName) {
                        setState(() {
                          _isBeingRenamed = false;
                          themesList[_beingChangedThemeIndex].name =
                              renamingTextController.text;
                        });
                      },
                      isRenamingNow:
                          _isBeingRenamed && _beingChangedThemeIndex == index,
                      renamingTextController: renamingTextController,
                      beginRenaming:
                          !themesList[_beingChangedThemeIndex].isImmutable
                              ? () {
                                  setState(
                                    () {
                                      renamingTextController.text =
                                          themesList[index].name;

                                      _isBeingRenamed = true;
                                    },
                                  );
                                }
                              : null,
                    );
            },
          ),
        ),
      ],
    );
  }

  Column rightColumn(UserThemeConfig current, BuildContext context) {
    var current = themesList[_beingChangedThemeIndex];
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Настройки выделенной темы'),
        ),
        Expanded(
          child: ListView(
            controller: ScrollController(),
            padding: const EdgeInsets.all(4),
            children: [
              SettingTile<Color>(
                showDialogCallback: () {
                  showDialog<Color>(
                    context: context,
                    builder: (context) =>
                        ColorPickerDialog(intialColor: current.primaryColor),
                  ).then((newValue) {
                    if (newValue != null) {
                      setState(() {
                        current.primaryColor = newValue;
                      });
                    }
                  });
                },
                settingName: 'Главный цвет темы',
                currentConfig: current,
                value: current.primaryColor,
                valueIcon: Icon(Icons.circle, color: current.primaryColor),
              ),
              SettingTile<Color>(
                showDialogCallback: () {
                  showDialog<Color>(
                    context: context,
                    builder: (context) =>
                        ColorPickerDialog(intialColor: current.backgroundColor),
                  ).then((newValue) {
                    if (newValue != null) {
                      setState(() {
                        current.backgroundColor = newValue;
                      });
                    }
                  });
                },
                settingName: 'Цвет фона',
                currentConfig: current,
                value: current.backgroundColor,
                valueIcon: Icon(
                  current.brightness == Brightness.light
                      ? Icons.brightness_5_rounded
                      : Icons.brightness_2_rounded,
                  color: current.primaryColor,
                ),
              ),
              SettingTile<double>(
                showDialogCallback: () {
                  showDialog<double>(
                    context: context,
                    builder: (context) => FontSizePickerDialog(
                        initialFontSizeFactor: current.fontSizeFactor),
                  ).then((newValue) {
                    if (newValue != null) {
                      setState(() {
                        current.fontSizeFactor = newValue;
                      });
                    }
                  });
                },
                settingName: 'Размер шрифтов',
                currentConfig: current,
                value: current.fontSizeFactor,
                valueIcon: Text(
                  '${(current.fontSizeFactor * 10).round()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SettingTile<Color>(
                showDialogCallback: () {
                  showDialog<Color>(
                    context: context,
                    builder: (context) {
                      return ColorPickerDialog(
                          intialColor: current.modifiedPackageColor);
                    },
                  ).then((newValue) {
                    if (newValue != null) {
                      setState(() {
                        current.modifiedPackageColor = newValue;
                      });
                    }
                  });
                },
                settingName: 'Измененный пакет',
                currentConfig: current,
                value: current.modifiedPackageColor,
                valueIcon: Icon(
                  Icons.abc,
                  color: current.modifiedPackageColor,
                ),
              ),
              SettingTile<Color>(
                showDialogCallback: () {
                  showDialog<Color>(
                    context: context,
                    builder: (context) {
                      return ColorPickerDialog(
                          intialColor: current.modifiedElementColor);
                    },
                  ).then((newValue) {
                    if (newValue != null) {
                      setState(() {
                        current.modifiedElementColor = newValue;
                      });
                    }
                  });
                },
                settingName: 'Измененный элемент',
                currentConfig: current,
                value: current.modifiedPackageColor,
                valueIcon: Icon(
                  Icons.abc,
                  color: current.modifiedElementColor,
                ),
              ),
              SettingTile<Color>(
                showDialogCallback: () {
                  showDialog<Color>(
                    context: context,
                    builder: (context) {
                      return ColorPickerDialog(
                          intialColor: current.crititcalColor);
                    },
                  ).then((newValue) {
                    if (newValue != null) {
                      setState(() {
                        current.crititcalColor = newValue;
                      });
                    }
                  });
                },
                settingName: 'Цвет критической ошибки',
                currentConfig: current,
                value: current.crititcalColor,
                valueIcon: Icon(
                  Icons.abc,
                  color: current.crititcalColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> actions() => [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text('Отменить'),
          ),
        ),
        // //Этот закоментированный код предназначен для случая, если захотим добавить кнопку, которая сохранит и обновит в провайдере и хранилище изменения внесенные пользователем без выхода из окна конфигуратора.
        // //This commented code below is intended for the case when we want to add function save and refresh all changes contributed by user within provider and local storage without exiting the window.
        // TextButton(
        //   onPressed: () {
        //     Provider.of<ThemeProvider>(context, listen: false)
        //         .refreshStoragedConfigurations(
        //             themesList.sublist(2), _beingChangedThemeIndex);
        //   },
        //   child: const Padding(
        //     padding: EdgeInsets.all(4),
        //     child: Text('Применить \nтему'),
        //   ),
        // ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
                context,
                FinalChanges(
                    newConfigList: themesList.sublist(2),
                    selectedOption: _beingChangedThemeIndex));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'Сохранить',
            ),
          ),
        )
      ];

  void addNewConfig(int index) {
    var currentTheme = themesList[_beingChangedThemeIndex];
    setState(() {
      renamingTextController.text = 'Настраиваемая тема $index';
      _beingChangedThemeIndex = index;
      UserThemeConfig newConfig = UserThemeConfig(
        backgroundColor: currentTheme.backgroundColor,
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
