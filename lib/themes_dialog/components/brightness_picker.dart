import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BrightnessPickerDialog extends StatefulWidget {
  /// initial selection for the slider
  final Brightness initialBrightness;

  BrightnessPickerDialog({Key? key, required this.initialBrightness})
      : super(key: UniqueKey());

  @override
  BrightnessPickerDialogState createState() => BrightnessPickerDialogState();
}

class BrightnessPickerDialogState extends State<BrightnessPickerDialog> {
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    _brightness = widget.initialBrightness;
    print('initializing br dialog with is ${_brightness}');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Brightness'),
      content: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (_brightness == Brightness.dark)
                setState(() {
                  _brightness = Brightness.light;
                });
              Navigator.pop(context, _brightness);
            },
            child: AnimatedContainer(
              height: 100,
              duration: Duration(milliseconds: 440),
              decoration: BoxDecoration(
                color: _brightness == Brightness.light
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 2, color: Theme.of(context).primaryColor),
              ),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.brightness_5_rounded),
                      Text(
                        'Light mode',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              if (_brightness == Brightness.light)
                setState(() {
                  _brightness = Brightness.dark;
                });
              Navigator.pop(context, _brightness);
            },
            child: AnimatedContainer(
              height: 100,
              duration: Duration(milliseconds: 440),
              decoration: BoxDecoration(
                color: _brightness == Brightness.dark
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 2, color: Theme.of(context).primaryColor),
              ),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.brightness_2_rounded),
                      Text(
                        'Dark mode',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
