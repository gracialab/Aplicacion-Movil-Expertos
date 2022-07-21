import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_fix_expert/core/api/rols_api.dart';
import 'package:mr_fix_expert/core/api/auth_api.dart';
import 'package:mr_fix_expert/core/api/user_api.dart';
import 'package:mr_fix_expert/core/config/strings.dart';
import 'package:mr_fix_expert/core/utils/hooks/alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix_expert/gui/widgets/snackbar_alert_widget.dart';

class RegisterController {
  late BuildContext _context;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  late FirebaseMessaging messaging = FirebaseMessaging.instance;

  final AuthApi _authApi = AuthApi();
  final UserApi _userApi = UserApi();
  final RolsApi _rolsApi = RolsApi();

  XFile? image;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final RegisterController _singleton = RegisterController._();
  factory RegisterController(BuildContext context) => _singleton._instancia(context);
  RegisterController._();

  RegisterController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void init() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  void savePhotoUser(XFile file) => image = file;

  void _showAlertError(String message) => useAlertMessage(
        context: _context,
        title: titleError,
        message: message,
      );

  void onRegister() {
    if (formKey.currentState!.validate()) {
      if (image != null) {
        final authProvider = _context.read<UserProvider>();
        authProvider.isLoading = true;
        _authApi.createAccount(emailController.text, passwordController.text).then((credential) {
          if (credential != null) {
            createUser(credential.user!.uid);
          }
        }).catchError((onError) {
          authProvider.isLoading = false;
          SnackBarFloating.show(
            _context,
            'El correo ya esta registrado',
            type: TypeAlert.error,
          );
        });
      } else {
        _showAlertError(photoError);
      }
    }
  }

  void createUser(String uid) async {
    final authProvider = _context.read<UserProvider>();

    final rol = await _rolsApi.getRols();
    String? token = await messaging.getToken();

    final UserModel user = UserModel(
      rol: rol?.docs.first.reference,
      isActive: true,
      id: uid,
      photo: '',
      fcmToken: token,
      email: emailController.text,
      firtsName: nameController.text,
      cellPhone: phoneController.text,
      lastName: lastNameController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final created = await _userApi.createUser(user);

    if (created) {
      final urlPhoto = await _userApi.uploadPhoto(File(image!.path), uid);

      if (urlPhoto != null) {
        _userApi.updateUser(user.copyWith(photo: urlPhoto));
      }

      authProvider.isLoading = false;

      useNavigateReplacePage(_context, 'main');
    }
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
  }
}
