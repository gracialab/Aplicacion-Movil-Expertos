import 'package:flutter/material.dart';

class ItemNotification extends StatelessWidget {
  final int index;
  const ItemNotification({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _icon(context),
        const SizedBox(width: 15),
        _textInfoNotification(),
        const SizedBox(width: 15),
        _dateNotification(),
      ],
    );
  }

  Widget _icon(BuildContext context) => Icon(
        index % 2 == 0 ? Icons.done : Icons.close,
        color: index % 2 == 0
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      );

  Widget _textInfoNotification() => Expanded(
        child: Text(
          "Notificacion $index",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      );

  Widget _dateNotification() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Text(
            "22/05/2021",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          Text(
            "12:00 PM",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      );
}
