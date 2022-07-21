import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/core/api/user_api.dart';
import 'package:mr_fix_expert/core/api/metadata_api.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix_expert/gui/widgets/snackbar_alert_widget.dart';
import 'package:mr_fix_expert/data/models/list_options_model/list_options_model.dart';

class EditProfileController {
  late BuildContext _context;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController lastNameController;
  late TextEditingController identificationController;

  XFile? image;
  ListOptionsModel? selectedIdentificationType;

  final UserApi _userApi = UserApi();
  final MetadataApi _metadataApi = MetadataApi();

  final List<ListOptionsModel> identificationTypes = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final EditProfileController _singleton = EditProfileController._();
  factory EditProfileController(BuildContext context) =>
      _singleton._instancia(context);
  EditProfileController._();

  EditProfileController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  Future<void> init() async {
    final user = _context.read<UserProvider>().user;

    final DocumentSnapshot? snapshotIdentificationTypes =
        await _metadataApi.getMetadataByKey(keyIdentificationsType);

    if (snapshotIdentificationTypes != null) {
      final Map<String, dynamic> data =
          snapshotIdentificationTypes.data() as Map<String, dynamic>;

      data.forEach((key, value) {
        if (user!.identification != null) {
          if (user.identification == value) {
            selectedIdentificationType = ListOptionsModel(
              label: key,
              value: value,
            );
          }
        }
        identificationTypes.add(ListOptionsModel(label: key, value: value));
      });
    }
    nameController = TextEditingController(text: user?.firtsName);
    phoneController = TextEditingController(text: user?.cellPhone);
    emailController = TextEditingController(text: user?.email);
    lastNameController = TextEditingController(text: user?.lastName);
    identificationController =
        TextEditingController(text: user?.identification);

    return;
  }

  void savePhotoUser(XFile file) => image = file;

  void updateUser() async {
    if (formKey.currentState!.validate()) {
      final userProvider = _context.read<UserProvider>();

      final user = userProvider.user!.copyWith(
        email: emailController.text,
        firtsName: nameController.text,
        cellPhone: phoneController.text,
        lastName: lastNameController.text,
        identification: identificationController.text,
        typeIdentification: selectedIdentificationType?.value,
      );
      userProvider.isLoadingUpdateProfile = true;

      final bool created = await _userApi.updateUser(user);

      if (created) {
        if (image != null) {
          final bool? imageDelete =
              await _userApi.deletePhoto(userProvider.user!.photo!);

          if (imageDelete!) {
            final urlPhoto =
                await _userApi.uploadPhoto(File(image!.path), user.id);

            if (urlPhoto != null) {
              await _userApi.updateUser(user.copyWith(photo: urlPhoto));
            }
          }
        }
        userProvider.isLoadingUpdateProfile = false;
        SnackBarFloating.show(
          _context,
          'Actualizado con éxito',
        );
        useNavigatePop(_context);
      } else {
        userProvider.isLoading = false;
        SnackBarFloating.show(
          _context,
          'Ocurrio un error, vuelva a intentar',
          type: TypeAlert.error,
        );
      }
    }
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    identificationTypes.clear();
    lastNameController.dispose();
    identificationController.dispose();
  }
}
