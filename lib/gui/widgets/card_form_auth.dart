import 'package:flutter/material.dart';

class CardFormAuth extends StatelessWidget {
  final Widget child;

  const CardFormAuth({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(40, 40, 40, (paddingBottom + 20)),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
