import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/gui/widgets/button_widget.dart';
import 'package:mr_fix_expert/gui/widgets/text_form_input.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/widgets/drop_button_widget.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_validations.dart';
import 'package:mr_fix_expert/gui/widgets/avatar_image_register.dart';

import '../edit_profile_controller.dart';

class FormEditProfile extends StatelessWidget {
  const FormEditProfile({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Form(
      key: controller.formKey,
      child: Column(
        children: <Widget>[
          Center(
            child: AvatarImageRegister(
              onClick: controller.savePhotoUser,
              label: 'Cambiar Foto',
              file: userProvider.user!.photo!.isNotEmpty
                  ? userProvider.user!.photo
                  : null,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 14),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ColorsAppTheme.greyAppPalette[200]!,
                        width: 2,
                      ),
                    ),
                  ),
                  child: DropDownButtonWidget(
                    listOptions: controller.identificationTypes,
                    title: 'Tipo de documento',
                    initialValue: controller.selectedIdentificationType,
                    onChanged: (value) =>
                        (controller.selectedIdentificationType = value),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                flex: 4,
                child: TextFormInput(
                  controller: controller.identificationController,
                  hintText: 'Número de identificación',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'La identificación es obligatoria';
                    } else if (!useValidateNumber(value)) {
                      return 'Formato inválido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
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
          const SizedBox(height: 45),
          userProvider.isLoadingUpdateProfile
              ? const ActivityIndicator()
              : ButtonWidget(
                  label: 'Actualizar',
                  onTap: controller.updateUser,
                ),
        ],
      ),
    );
  }
}
