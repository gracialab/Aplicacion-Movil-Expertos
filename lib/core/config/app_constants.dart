import 'package:mr_fix_expert/data/models/list_options_model/list_options_model.dart';

const double paddingBottomAppBarTabs = 6;
const String keyIdentificationsType = "identificationType";
const String keyCollectionKey = "keys";
const String keyEncryption = "encryptionKey";
const String secretKeyDefault = "mrfixexpert";

// API KEY PROJECT FOR PUSH NOTIFICATIONS
const String urlNotificationSend = "https://fcm.googleapis.com/fcm/send";
const String serverKey =
    "AAAA0tHHXA8:APA91bGLHVxZUNTOidyUN_40v9Ab3zmTxvO_wwcQphBHTEBFScIjWR02TEm3ZKdedg-rLTAGQymmC-faSpUj6vw1NL4gkcAOkg41YupkTB9TBeVndvpvnjAheq4IozxdXHY5zjpLpFcu";
const String keyOtherUser =
    "dgBZN8g8SwGLi_DmbsDrjh:APA91bHpD3-cTUstsSqWrcPh4nItu_nk-9uymy4ij9IegPdPZXaOsV7sOvInMmFiC8bytUk3J9ZwRaGuFkI3nwSIrxZnBmR6RgbN-MS7W9tP4E9nejqjQ2QX2i8rV0hOld5gl5oevEGF";
final List<ListOptionsModel> numberDues = List.generate(
  12,
  (index) {
    final value = index + 1;
    return ListOptionsModel(label: value.toString(), value: value);
  },
);

//#region Status Purchase
const int availableStatus = 0;
const int confirmedStatus = 1;
const int inProgressStatus = 2;
const int finishStatus = 3;
const int canceledStatus = 4;
//endregion

//#region Status Payment
const int paidStatus = 0;
const int rejectedStatus = 1;
//endregion

const List<ListOptionsModel> listStatusPurchase = [
  ListOptionsModel(label: 'Disponibles', value: availableStatus),
  ListOptionsModel(label: 'Finalizados', value: finishStatus),
  ListOptionsModel(label: 'Cancelados', value: canceledStatus),
];
