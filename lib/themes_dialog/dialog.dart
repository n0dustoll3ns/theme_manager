import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themes_sandbox/UX/hex_to_string_converter.dart';
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
          themesList[_beingChangedThemeIndex].name =
              renamingTextController.text;
        });
      }
    });
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
                        print(themesList[_beingChangedThemeIndex]
                            .primaryColor
                            .toHex());
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
                      beginRenaming: () {
                        setState(
                          () {
                            _beingChangedThemeIndex = index;
                            currentColor = themesList[index].primaryColor;
                            currentBrightness = themesList[index].brightness;
                            fontSizeFactor = themesList[index].fontSizeFactor;
                            renamingTextController.text =
                                themesList[index].name;

                            _isBeingRenamed = true;
                          },
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }

  Column rightColumn(UserThemeConfig current, BuildContext context) {
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
              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                child: SizedBox(
                  height: 34,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Основной цвет'),
                      )),
                      IconButton(
                        hoverColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        iconSize: Theme.of(context).iconTheme.size ?? 24 * 0.8,
                        onPressed: current.isImmutable
                            ? null
                            : _showPrimaryColorPickerDialog,
                        icon: Icon(Icons.circle, color: current.primaryColor),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Цвет фона'),
                      )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: Theme.of(context).iconTheme.size ?? 24 * 0.8,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Размер шрифтов'),
                      )),
                      TextButton(
                        onPressed: current.isImmutable
                            ? null
                            : _showFontSizePickerDialog,
                        child: Text(
                          '${(current.fontSizeFactor * 100).round()} %',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Измененный пакет'),
                      )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: Theme.of(context).iconTheme.size ?? 24 * 0.8,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Измененный элемент'),
                      )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: Theme.of(context).iconTheme.size ?? 24 * 0.8,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Цвет критической ошибки'),
                      )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: Theme.of(context).iconTheme.size ?? 24 * 0.8,
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
      renamingTextController.text = 'Настраиваемая тема $index';
      _beingChangedThemeIndex = index;
      UserThemeConfig newConfig = UserThemeConfig(
        brightness: currentTheme.brightness,
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
