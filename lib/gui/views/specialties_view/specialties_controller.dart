import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/api/user_api.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix_expert/gui/widgets/snackbar_alert_widget.dart';

class SpecialtiesController {
  late BuildContext _context;

  final UserApi userApi = UserApi();

  static final SpecialtiesController _singleton = SpecialtiesController._();
  factory SpecialtiesController(BuildContext context) => _singleton._instancia(context);
  SpecialtiesController._();

  SpecialtiesController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void toogleSpecialties(DocumentReference idSpecialty) {
    final userProvider = _context.read<UserProvider>();

    final UserModel currentUser = userProvider.user!;

    final List<DocumentReference> specialties = currentUser.specialties ?? [];

    if (specialties.contains(idSpecialty)) {
      specialties.remove(idSpecialty);
    } else {
      specialties.add(idSpecialty);
    }

    userProvider.user = currentUser.copyWith(specialties: specialties);
  }

  void saveSpecialties() async {
    final userProvider = _context.read<UserProvider>();

    userProvider.isLoadingUpdateProfile = true;
    final bool response = await userApi.updateUser(userProvider.user!);

    if (response) {
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
