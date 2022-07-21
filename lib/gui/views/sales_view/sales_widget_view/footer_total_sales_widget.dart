import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/core/utils/parse_number.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class FooterTotalWidget extends StatelessWidget {
  const FooterTotalWidget({
    Key? key,
    required this.currentMont,
    required this.totalSalesByMonth,
  }) : super(key: key);

  final String currentMont;
  final int totalSalesByMonth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          color: ColorsAppTheme.greyAppPalette[100],
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Feather.dollar_sign,
            size: 18,
            color: ColorsAppTheme.threeColor,
          ),
          const Spacer(),
          Text(
            "Total $currentMont",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            ParseNumber.currency(value: totalSalesByMonth),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: ColorsAppTheme.threeColor,
            ),
          ),
        ],
      ),
    );
  }
}
