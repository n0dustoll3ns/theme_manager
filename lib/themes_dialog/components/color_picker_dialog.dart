import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  @override
  void initState() {
    super.initState();
    _color = widget.intialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Выберите цвет'),
      content: SizedBox(
        child: BlockPicker(
          pickerColor: _color,
          onColorChanged: (Color color) {
            setState(() => _color = color);
            Navigator.pop(context, color);
          },
        ),
      ),
    );
  }
}
