import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/api/user_api.dart';
import 'package:mr_fix_expert/core/api/auth_api.dart';
import 'package:mr_fix_expert/core/api/rols_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix_expert/gui/widgets/snackbar_alert_widget.dart';

class LoginControllerView {
  late BuildContext _context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthApi _authApi = AuthApi();
  final UserApi _userApi = UserApi();
  final RolsApi _rolApi = RolsApi();

  //TextEditingController for inputs
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final LoginControllerView _singleton = LoginControllerView._();
  factory LoginControllerView(BuildContext context) => _singleton._instancia(context);
  LoginControllerView._();

  LoginControllerView _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void onLogin() {
    if (formKey.currentState!.validate()) {
      final authProvider = _context.read<UserProvider>();
      authProvider.isLoading = true;
      _authApi
          .signIn(emailController.text.trim().toLowerCase(), passwordController.text.trim())
          .then((credential) async {
        if (credential != null) {
          final userDetail = await _userApi.getUserDetail(credential.user!.uid);
          final queryRol = await _rolApi.getRols();

          final rol = queryRol?.docs.first;
          final UserModel? user = userDetail?.data();

          authProvider.isLoading = false;

          if (rol != null) {
            if (rol.reference.id == user?.rol?.id) {
              String? token = await messaging.getToken();
              await _userApi.updateUser(user!.copyWith(fcmToken: token));
              useNavigateReplaceName(_context, 'main');
            } else {
              _alertError();
            }
          } else {
            _alertError();
          }
        }
      }).catchError((onError) {
        authProvider.isLoading = false;
        _alertError();
      });
    }
  }

  void _alertError() {
    SnackBarFloating.show(
      _context,
      'Usuario o contraseña incorrectos',
      type: TypeAlert.error,
    );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
