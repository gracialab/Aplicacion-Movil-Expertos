import 'package:flutter/material.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/core/paths/local_paths.dart';
import 'package:mr_fix_expert/gui/widgets/card_form_auth.dart';
import 'package:mr_fix_expert/gui/widgets/background_gradient.dart';

const double marginLeadingAppBar = 20.0;

class AuthTemplate extends StatelessWidget {
  final Widget child;

  const AuthTemplate({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(showGradient: false),
      body: BackGroundGradient(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Image.asset(
                  LocalAppPaths.logo,
                  width: 220,
                  fit: BoxFit.contain,
                ),
              ),
              CardFormAuth(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
