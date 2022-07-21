import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/gui/widgets/card_widget.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/gui/widgets/button_widget.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';
import 'package:mr_fix_expert/gui/views/home_view/home_controller.dart';

class RowButtons extends StatelessWidget {
  const RowButtons({
    Key? key,
    required this.purchase,
    required this.controller,
  }) : super(key: key);

  final PurchaseModel purchase;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _button(
          onTap: purchase.statusPurchase == confirmedStatus
              ? () => controller.onInitSerice(purchase)
              : () => controller.onFinishService(purchase),
          margin: const EdgeInsets.only(right: 10),
          text: purchase.statusPurchase == inProgressStatus
              ? 'Finalizar'
              : 'Iniciar',
        ),
        purchase.statusPurchase == confirmedStatus
            ? _button(
                onTap: () => controller.onCancelService(purchase),
                text: 'Cancelar',
              )
            : const SizedBox(),
        _button(
          onTap: () => controller.onRedirectToMap(purchase),
          margin: const EdgeInsets.only(left: 10),
          text: "¿Cómo llegar?",
        ),
      ],
    );
  }

  Widget _button({
    required String text,
    required VoidCallback onTap,
    TextStyle? textStyle,
    EdgeInsetsGeometry? margin,
  }) =>
      Flexible(
        child: CardWidget(
          padding: EdgeInsets.zero,
          margin: margin,
          child: ButtonWidget(
            label: text,
            height: 45,
            onTap: onTap,
            margin: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorsAppTheme.secondColor,
            ).merge(textStyle),
          ),
        ),
      );
}
