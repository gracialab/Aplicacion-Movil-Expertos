import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomSheetImagePicker {
  List items;

  BottomSheetImagePicker({required this.items});

  getItems(BuildContext context) {
    var options = <Widget>[];
    if (Platform.isAndroid) {
      for (var i = 0; i < items.length; i++) {
        options.add(ListTile(
          leading: Icon(items[i]['icon']),
          title: Text(
            items[i]['label'],
            style: TextStyle(
              color: items[i]['color'] ?? Colors.black54,
            ),
          ),
          onTap: () => Navigator.pop(context, items[i]['value']),
        ));
      }
    } else {
      for (var i = 0; i < items.length; i++) {
        if (!items[i]['isCancel']) {
          options.add(CupertinoActionSheetAction(
            isDefaultAction: items[i]['isCancel'] ?? false,
            child: Text(
              items[i]['label'],
              style: TextStyle(
                color: items[i]['color'] ?? Colors.blueAccent,
              ),
            ),
            onPressed: () => Navigator.pop(context, items[i]['value']),
          ));
        }
      }
    }
    return options;
  }

  Future show(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Elige una opción'),
          actions: <Widget>[...getItems(context)],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancelar'),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, null),
          ),
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[...getItems(context)],
          );
        },
      );
    }
  }
}
