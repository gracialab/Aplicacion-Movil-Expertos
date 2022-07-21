import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:mr_fix_expert/core/utils/parse_number.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

class HeaderCardExpandable extends StatefulWidget {
  const HeaderCardExpandable({
    Key? key,
    required this.purchase,
    required this.controllerExpanded,
  }) : super(key: key);

  final PurchaseModel purchase;
  final ExpandableController controllerExpanded;

  @override
  State<HeaderCardExpandable> createState() => _HeaderCardExpandableState();
}

class _HeaderCardExpandableState extends State<HeaderCardExpandable> {
  bool _sExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 26,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: widget.purchase.service.image!.isNotEmpty
                  ? Image(
                      image: NetworkImage(widget.purchase.service.image!),
                    )
                  : Icon(
                      Icons.directions_bike_rounded,
                      color: Colors.grey[400],
                    ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
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
                ParseNumber.currency(value: widget.purchase.service.price),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
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
