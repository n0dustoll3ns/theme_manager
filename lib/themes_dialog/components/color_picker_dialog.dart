import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color intialColor;

  const ColorPickerDialog({Key? key, required this.intialColor})
      : super(key: key);

  @override
  State<ColorPickerDialog> createState() => ColorPickerDialogState();
}

class ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color _color;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    _color = widget.intialColor;
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выберите цвет'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorPicker(
            pickerColor: _color,
            onColorChanged: (Color color) {
              setState(() => _color = color);
            },
            pickerAreaHeightPercent: 0.7,
            enableAlpha: false,
            displayThumbColor: true,
            paletteType: PaletteType.hsvWithHue,
            labelTypes: const [],
            pickerAreaBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            hexInputController: textController,
            portraitOnly: true,
          ),
          TextField(
            style: TextStyle(
                fontSize:
                    Theme.of(context).textTheme.bodyMedium!.fontSize ?? 12),
            readOnly: false,
            decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.tag),
                ),
                suffixIcon: IconButton(
                    onPressed: () => {
                          Clipboard.setData(
                              ClipboardData(text: textController.text))
                        },
                    icon: const Icon(Icons.content_copy))),
            controller: textController,
            autofocus: true,
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp(kValidHexPattern))
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Сохранить'),
          onPressed: () {
            Navigator.pop(context, _color);
          },
        ),
      ],
    );
  }
}
