import 'package:flutter/material.dart';

class ViewportSizeAlertDialog extends StatelessWidget {
  const ViewportSizeAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Предупреждение'),
      content: const SizedBox(
        child: Text('Сделайте окно браузера больше.'),
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
