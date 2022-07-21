import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

class HeaderCardExpandable extends StatefulWidget {
  const HeaderCardExpandable({
    Key? key,
    required this.purchaseModel,
    required this.controllerExpanded,
  }) : super(key: key);

  final PurchaseModel purchaseModel;
  final ExpandableController controllerExpanded;

  @override
  _HeaderCardExpandableState createState() => _HeaderCardExpandableState();
}

class _HeaderCardExpandableState extends State<HeaderCardExpandable> {
  bool _sExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Feather.dollar_sign,
            size: 20,
            color: ColorsAppTheme.primaryColor,
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.purchaseModel.service.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.purchaseModel.address.split(",")[0],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Text(
                  "\$ ${widget.purchaseModel.service.price.toString()}",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  Jiffy(widget.purchaseModel.date.toString())
                      .format("dd/MM/yy"),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            _sExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  void _onTap() {
    setState(() {
      _sExpanded = !_sExpanded;
    });
    widget.controllerExpanded.toggle();
  }
}
