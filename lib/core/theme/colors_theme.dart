import 'package:flutter/material.dart';

class ColorsAppTheme {
  static const int _valuePrimaryColor = 0xFFFF5300,
      _valueSecondColor = 0xFFBF0051,
      _valueThreeColor = 0xFF00A126,
      _valueRedColor = 0xFFD3072A;

  static const Color primaryColor = Color(_valuePrimaryColor),
      secondColor = Color(_valueSecondColor),
      threeColor = Color(_valueThreeColor),
      redColor = Color(_valueRedColor);

  static MaterialColor greyAppPalette = const MaterialColor(0xFFA6A6A6, {
    50: Color(0xFFfcfcfc),
    100: Color(0xFFE5E5E5),
    200: Color(0xFFC8C8C8),
  });
}
