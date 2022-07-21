import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Future<String?> useAlertMessage({
  required BuildContext context,
  String title = '',
  String message = '',
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop('false');
              },
              child: const Text('Cancelar'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop('true');
              },
              child: const Text('Aceptar'),
            )
          ],
        );
      } else {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('false');
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('true');
              },
              child: const Text('Aceptar'),
            )
          ],
        );
      }
    },
  );
}
