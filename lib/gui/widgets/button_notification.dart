import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ButtonNotification extends StatelessWidget {
  const ButtonNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'notification'),
      child: Align(
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.only(
            right: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Feather.bell,
            size: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
