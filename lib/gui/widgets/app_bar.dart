import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? centerTitle;
  final double? elevation;
  final bool? showGradient;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    this.title,
    this.bottom,
    this.elevation = 0,
    this.actions = const [],
    this.centerTitle,
    this.showGradient = true,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: showGradient!
            ? LinearGradient(
                begin: const Alignment(3, 0.0),
                end: Alignment.centerLeft,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              )
            : null,
      ),
      child: AppBar(
        title: title,
        bottom: bottom,
        actions: actions,
        elevation: elevation,
        centerTitle: centerTitle,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }

  double _getSizeHeightHeader() {
    if (bottom != null) {
      return (kToolbarHeight +
          bottom!.preferredSize.height +
          paddingBottomAppBarTabs);
    }
    return kToolbarHeight;
  }

  @override
  Size get preferredSize => Size.fromHeight(_getSizeHeightHeader());
}
