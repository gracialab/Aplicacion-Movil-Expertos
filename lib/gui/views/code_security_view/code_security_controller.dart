import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mr_fix_expert/core/api/metadata_api.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/providers/purchase_provider.dart';

class CodeSecurityController {
  late BuildContext _context;
  late String encryptedData;

  final MetadataApi _metadataApi = MetadataApi();

  static final CodeSecurityController _singleton = CodeSecurityController._();
  factory CodeSecurityController(BuildContext context) =>
      _singleton._instancia(context);
  CodeSecurityController._();

  CodeSecurityController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  Future<void> encryptData() async {
    String secretKey = secretKeyDefault;
    final purchaseProvider = _context.read<PurchaseProvider>();
    final currentUser = _context.read<UserProvider>().user;
    final keysDocument = await _metadataApi.getMetadataByKey(keyCollectionKey);

    if (keysDocument != null) {
      final Map<String, dynamic> data =
          keysDocument.data() as Map<String, dynamic>;

      secretKey = data[keyEncryption];
    }

    final jwt = JWT(
      {
        'idExpert': currentUser!.id,
        'idService': purchaseProvider.selectedPurchase!.id,
        'idUser': purchaseProvider.selectedPurchase!.user!.id,
      },
    );

    encryptedData = jwt.sign(SecretKey(secretKey));
    return;
  }
}
