import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    this.margin,
    this.padding,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: ColorsAppTheme.greyAppPalette[50],
        border: Border.all(
          color: ColorsAppTheme.greyAppPalette[100]!,
        ),
      ),
      child: child,
    );
  }
}
