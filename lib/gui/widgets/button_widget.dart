import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.width,
    this.onTap,
    this.margin,
    this.leading,
    this.textStyle,
    this.height = 50,
    this.enabled = true,
    this.backgroundColor,
    required this.label,
  }) : super(key: key);

  final bool enabled;
  final String label;
  final double? width;
  final double? height;
  final Function? onTap;
  final Widget? leading;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          if (enabled) {
            onTap?.call();
          }
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: _validateEnabled(context),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading != null ? leading! : const SizedBox(),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ).merge(textStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _validateEnabled(BuildContext context) {
    return enabled
        ? backgroundColor ?? Theme.of(context).primaryColor
        : Colors.grey[300];
  }
}
