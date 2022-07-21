import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/gui/widgets/button_widget.dart';
import 'package:mr_fix_expert/gui/widgets/text_form_input.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_validations.dart';
import 'package:mr_fix_expert/gui/widgets/avatar_image_register.dart';

import 'register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final RegisterController controller;

  @override
  void initState() {
    controller = RegisterController(context)..init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.watch<UserProvider>().isLoading;
    return Scaffold(
      appBar: const CustomAppBar(
        showGradient: true,
        title: Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: AvatarImageRegister(
                    onClick: controller.savePhotoUser,
                    label: "Tomar foto",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormInput(
                  controller: controller.nameController,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: 'Nombre',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'El nombre obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormInput(
                  controller: controller.lastNameController,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: 'Apellido',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'El apellido obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormInput(
                  controller: controller.phoneController,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: 'Teléfono',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'El teléfono obligatorio';
                    } else if (!useValidateNumber(value)) {
                      return 'Formato inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormInput(
                  controller: controller.emailController,
                  keyBoardType: TextInputType.emailAddress,
                  hintText: 'Ingresa tu correo',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'El email obligatorio';
                    } else if (!useValidateEmail(value)) {
                      return 'Formato inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormInput(
                  controller: controller.passwordController,
                  obscureText: true,
                  hintText: 'Ingresa tu nueva contraseña',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'La contraseña es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 45),
                isLoading
                    ? const ActivityIndicator()
                    : ButtonWidget(
                        label: 'Crear cuenta',
                        onTap: controller.onRegister,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
