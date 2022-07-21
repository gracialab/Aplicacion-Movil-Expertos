import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';

class AppTheme {
  static ThemeData light() {
    final ThemeData theme = ThemeData(
      fontFamily: 'Montserrat',
      brightness: Brightness.light,
      primaryColor: ColorsAppTheme.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: ColorsAppTheme.primaryColor,
        secondary: ColorsAppTheme.secondColor,
      ),
    );
  }
}
