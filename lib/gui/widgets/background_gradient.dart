import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/paths/local_paths.dart';

class BackGroundGradient extends StatelessWidget {
  final Widget child;

  const BackGroundGradient({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            LocalAppPaths.gradientBackground,
          ),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: child,
        ),
      ),
    );
  }
}
