import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

class HeaderCardAssigned extends StatefulWidget {
  const HeaderCardAssigned({
    Key? key,
    required this.purchase,
    required this.controllerExpanded,
  }) : super(key: key);

  final PurchaseModel purchase;
  final ExpandableController controllerExpanded;

  @override
  State<HeaderCardAssigned> createState() => _HeaderCardAssignedState();
}

class _HeaderCardAssignedState extends State<HeaderCardAssigned> {
  bool _sExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Jiffy(widget.purchase.hour).format('hh:mm a'),
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.purchase.service.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.purchase.address.split(',')[0],
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
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
