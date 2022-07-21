import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/gui/widgets/card_widget.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/views/code_security_view/code_security_controller.dart';

class CodeSecurityView extends StatefulWidget {
  const CodeSecurityView({Key? key}) : super(key: key);

  @override
  State<CodeSecurityView> createState() => _CodeSecurityViewState();
}

class _CodeSecurityViewState extends State<CodeSecurityView> {
  bool _isLoading = true;
  late CodeSecurityController controller;

  @override
  void initState() {
    controller = CodeSecurityController(context);
    controller.encryptData().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Text("Codigo de Seguridad")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Comunicate con el cliente y pídele que por favor escanee el código de seguridad",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const ActivityIndicator()
                : CardWidget(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        QrImage(
                          data: controller.encryptedData,
                          version: QrVersions.auto,
                          size: 250.0,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Codigó de Seguridad",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
