import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/data/models/type_alert_snackBar_model.dart';

enum TypeAlert {
  success,
  error,
  warning,
  info,
}

const Map<String, TypeAlertSnackBar> typeAlert = {
  'success': TypeAlertSnackBar(
    label: 'Success',
    color: Colors.green,
    icon: Icons.check_circle,
  ),
  'error': TypeAlertSnackBar(
    label: 'Error',
    icon: Icons.error,
    color: ColorsAppTheme.redColor,
  ),
};

class SnackBarFloating {
  static void show(
    BuildContext context,
    String message, {
    IconData? icon,
    Color? backgroundColor,
    TypeAlert type = TypeAlert.success,
  }) {
    final _typeAlert = _getTypeAlertSnackBar(type).copyWith(
      icon: icon,
      label: message,
      color: backgroundColor,
    );

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            _typeAlert.icon,
            size: 22,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(_typeAlert.label),
        ],
      ),
      backgroundColor: _typeAlert.color,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static TypeAlertSnackBar _getTypeAlertSnackBar(TypeAlert type) {
    switch (type) {
      case TypeAlert.success:
        return typeAlert['success']!;
      case TypeAlert.error:
        return typeAlert['error']!;
      default:
        return typeAlert['success']!;
    }
  }
}
