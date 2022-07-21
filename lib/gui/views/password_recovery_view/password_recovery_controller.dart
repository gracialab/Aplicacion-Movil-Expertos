import 'package:flutter/material.dart';

class PasswordRecoveryController {
  late BuildContext _context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final bool addfields = false;

  static final PasswordRecoveryController _singleton =
      PasswordRecoveryController._();
  factory PasswordRecoveryController(BuildContext context) =>
      _singleton._instancia(context);
  PasswordRecoveryController._();

  PasswordRecoveryController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void onChangePassword() {
    if (formKey.currentState!.validate()) {
      print('Bien');
    }
  }

  void onRequestCode() {
    if (formKey.currentState!.validate() && addfields == true) {
      print("completed");
    }
  }
}
