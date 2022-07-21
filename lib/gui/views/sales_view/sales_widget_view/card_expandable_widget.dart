import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:mr_fix_expert/gui/widgets/info_card_expandable.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';
import 'package:mr_fix_expert/gui/views/sales_view/sales_widget_view/header_expandable_widget.dart';

class CardExpandablewidget extends StatelessWidget {
  CardExpandablewidget({Key? key, required this.purchase}) : super(key: key);

  final PurchaseModel purchase;

  final ExpandableController _controllerExpanded = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: Container(),
      controller: _controllerExpanded,
      header: HeaderCardExpandable(
          purchaseModel: purchase, controllerExpanded: _controllerExpanded),
      expanded: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            ItemCardExpandable(
              icon: Icons.calendar_today,
              label: 'Día:',
              value: Jiffy(purchase.date.toString()).format("dd MMMM yyy"),
            ),
            ItemCardExpandable(
              icon: Icons.access_time,
              label: 'Hora:',
              value: Jiffy(purchase.hour.toString()).format("hh:mm a"),
            ),
            ItemCardExpandable(
              icon: Icons.add,
              label: 'Dirección:',
              value: purchase.address,
            ),
            ItemCardExpandable(
              icon: Icons.attach_money,
              label: 'Valor del servicio:',
              value: "\$ ${purchase.service.price.toString()}",
            ),
            const ItemCardExpandable(
              icon: Icons.credit_card_outlined,
              label: 'Método de pago:',
              value: 'T. Crédito',
            ),
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
}
