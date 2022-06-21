import 'package:flutter/material.dart';

class FontSizePickerDialog extends StatefulWidget {
  /// initial selection for the slider
  final double initialFontSizeFactor;

  const FontSizePickerDialog({Key? key, required this.initialFontSizeFactor})
      : super(key: key);

  @override
  FontSizePickerDialogState createState() => FontSizePickerDialogState();
}

class FontSizePickerDialogState extends State<FontSizePickerDialog> {
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.initialFontSizeFactor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Размер шрифтов'),
      content: SizedBox(
        height: 35,
        child: Slider(
            value: _fontSize,
            divisions: 15,
            min: 0.5,
            max: 2,
            label: '${(_fontSize * 10).round()}',
            onChanged: (double value) {
              setState(() {
                _fontSize = value;
              });
            },
            onChangeEnd: (double value) {
              Navigator.pop(context, _fontSize);
            }),
      ),
    );
  }
}
