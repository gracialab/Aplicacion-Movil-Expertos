import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/core/utils/parse_number.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/widgets/button_widget.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/gui/widgets/info_card_expandable.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';
import 'package:mr_fix_expert/gui/views/services_view/services_controller.dart';

import 'header_card_expandable.dart';

class CardService extends StatelessWidget {
  CardService({
    Key? key,
    required this.purchase,
    required this.constoller,
  }) : super(key: key);

  final ServicesController constoller;
  final PurchaseModel purchase;

  final ExpandableController _controllerExpanded = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      controller: _controllerExpanded,
      collapsed: Container(),
      header: HeaderCardExpandable(
        controllerExpanded: _controllerExpanded,
        purchase: purchase,
      ),
      expanded: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            _clientInfo(),
            ItemCardExpandable(
              icon: Icons.calendar_today,
              label: 'Día:',
              value: Jiffy(purchase.date).yMMMEd,
            ),
            ItemCardExpandable(
              icon: Icons.access_time,
              label: 'Hora:',
              value: Jiffy(purchase.hour).format('hh:mm a'),
            ),
            ItemCardExpandable(
              icon: Icons.add,
              label: 'Dirección:',
              value: purchase.address,
            ),
            ItemCardExpandable(
              icon: Icons.attach_money,
              label: 'Valor del servicio:',
              value: ParseNumber.currency(value: purchase.service.price),
            ),
            const ItemCardExpandable(
              icon: Icons.credit_card_outlined,
              label: 'Método de pago:',
              value: 'T. Crédito',
            ),
            const SizedBox(height: 20),
            purchase.statusPurchase == availableStatus ? _button(context) : const SizedBox(),
          ],
        ),
      ),
      theme: const ExpandableThemeData(
        hasIcon: false,
        tapHeaderToExpand: false,
        tapBodyToCollapse: false,
        tapBodyToExpand: false,
      ),
    );
  }

  Widget _clientInfo() => FutureBuilder<DocumentSnapshot>(
        future: purchase.user!.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ActivityIndicator();
          }

          final client = UserModel.fromJson(snapshot.data!.data()! as Map<String, dynamic>);

          return ItemCardExpandable(
            icon: Icons.add,
            label: 'Cliente:',
            value: "${client.firtsName} ${client.lastName}",
          );
        },
      );

  Widget _button(BuildContext context) => ButtonWidget(
        label: "Tomar servicio",
        onTap: () => constoller.takeService(purchase),
        margin: const EdgeInsets.only(bottom: paddingBottomAppBarTabs),
        textStyle: const TextStyle(fontSize: 14),
      );
}
