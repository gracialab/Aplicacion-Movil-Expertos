import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/gui/views/services_view/services_controller.dart';
import 'package:mr_fix_expert/gui/widgets/card_widget.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';
import 'package:mr_fix_expert/gui/views/services_view/services_widgets/card_service_widget.dart';

class ListServices extends StatelessWidget {
  const ListServices({
    Key? key,
    this.data,
  }) : super(key: key);

  final QuerySnapshot? data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: data?.size ?? 0,
      itemBuilder: (context, index) {
        final doc = data!.docs[index];

        final PurchaseModel purchase =
            PurchaseModel.fromJson(doc.data()! as Map<String, dynamic>);

        return CardWidget(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: CardService(
            purchase: purchase,
            constoller: ServicesController(context),
          ),
        );
      },
    );
  }
}
