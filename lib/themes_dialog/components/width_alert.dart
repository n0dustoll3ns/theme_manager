import 'package:flutter/material.dart';

class ViewPortWidthAlertDialog extends StatelessWidget {
  const ViewPortWidthAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Предупреждение'),
      content: const SizedBox(
        child: Text(
            'Сделайте окно браузера больше. Минимальная ширина: 660 пикселей'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('ОК'),
        )
      ],
    );
  }
}
