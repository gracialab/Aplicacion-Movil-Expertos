import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/api/purchase_api.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_launch_url.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix_expert/core/providers/purchase_provider.dart';
import 'package:mr_fix_expert/gui/widgets/snackbar_alert_widget.dart';
import 'package:mr_fix_expert/core/utils/send_push_notification.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

class HomeController {
  late BuildContext _context;
  DateTime selected = DateTime.now();
  ValueNotifier<DateTime> maxDate = ValueNotifier<DateTime>(DateTime.now());

  final PurchaseApi _purchaseApi = PurchaseApi();

  static final HomeController _singleton = HomeController._();
  factory HomeController(BuildContext context) => _singleton._instancia(context);
  HomeController._();

  HomeController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void init() {
    maxDate.value = DateTime(selected.year, selected.month, selected.day, 0, 0);
  }

  void onSelectedDate(DateTime selectDay, DateTime _) {
    selected = selectDay;
    maxDate.value = DateTime(selected.year, selected.month, selected.day, 0, 0);
  }

  void onInitSerice(PurchaseModel purchase) async {
    _context.read<PurchaseProvider>().selectedPurchase = purchase;
    useNavigatePushName(_context, 'codeqr');

    SendPushNotifications.sendNotification(
      title: "Holaa",
      body: "Soy una prueba",
      bodyData: {
        "idService": purchase.service.reference!.id,
      },
      registrationToken: keyOtherUser,
    );
  }

  void onFinishService(PurchaseModel purchase) async {
    final bool response = await _purchaseApi.updatePurchase(
      purchase.id,
      purchase.copyWith(statusPurchase: finishStatus),
    );

    if (response) {
      SnackBarFloating.show(_context, 'El servicio ha finalizó');

      SendPushNotifications.sendNotification(
        registrationToken: keyOtherUser,
        title: "Servicio Finalizado",
        body: "el servicio fue finalizado satisfactoriamente",
        bodyData: {
          "idService": purchase.service.reference!.id,
        },
      );
    } else {
      SnackBarFloating.show(
        _context,
        'Ocurrió un error, vuelve a intentar',
        type: TypeAlert.error,
      );
    }
  }

  void onCancelService(PurchaseModel purchase) async {
    final bool response = await _purchaseApi.updatePurchase(
      purchase.id,
      purchase.copyWith(statusPurchase: canceledStatus),
    );

    if (response) {
      SnackBarFloating.show(_context, 'Servicio cancelado');
      SendPushNotifications.sendNotification(registrationToken: keyOtherUser);
    } else {
      SnackBarFloating.show(
        _context,
        'Ocurrió un error, vuelve a intentar',
        type: TypeAlert.error,
      );
    }
  }

  void onRedirectToMap(PurchaseModel purchase) => useLaunchURL(
        "https://www.google.com/maps/place/4%C2%B037'15.3%22N+74%C2%B008'28.4%22W/@${purchase.coordinates.latitude},${purchase.coordinates.longitude},17z/data=!3m1!4b1!4m5!3m4!1s0x0:0xa18f5bf770ee3c8d!8m2!3d4.6209189!4d-74.1412256?hl=es",
      );
}

//transferencia www.mipagoamigo.com 
// recibos y facturas opcion 
//promotoras de inversiones y cobranzas, pagar y continuar
//30019592155 numero de producto
//opcion pago a cuotas
//3158863939