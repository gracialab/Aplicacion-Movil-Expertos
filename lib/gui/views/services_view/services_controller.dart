import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/api/purchase_api.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/gui/widgets/snackbar_alert_widget.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

class ServicesController {
  late BuildContext _context;

  final PurchaseApi _purchaseApi = PurchaseApi();

  static final ServicesController _singleton = ServicesController._();
  factory ServicesController(BuildContext context) =>
      _singleton._instancia(context);
  ServicesController._();

  ServicesController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void takeService(PurchaseModel purchase) async {
    final user = _context.read<UserProvider>().user;
    final bool response = await _purchaseApi.updatePurchase(
      purchase.id,
      purchase.copyWith(
        expert: user!.reference,
        statusPurchase: confirmedStatus,
      ),
    );

    if (response) {
      SnackBarFloating.show(_context, 'Servicio asignado correctamente');
    } else {
      SnackBarFloating.show(
        _context,
        'Ocurrió un error, vuelve a intentar',
        type: TypeAlert.error,
      );
    }
  }
}
