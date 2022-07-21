import 'package:flutter/material.dart';
import 'package:any_link_preview/parser/base.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/gui/widgets/button_widget.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/widgets/link_preview_widget.dart';

class CardVideoTutorial extends StatelessWidget {
  const CardVideoTutorial({
    Key? key,
    this.onTap,
    required this.link,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String link;
  final String title;
  final String description;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: ColorsAppTheme.greyAppPalette[50],
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: ColorsAppTheme.greyAppPalette[100]!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          LinkPreview(
            link: link,
            builder: (bool isLoading, BaseMetaInfo? info) => isLoading
                ? const ActivityIndicator()
                : Image.network(
                    info!.image!,
                    height: 200,
                  ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ButtonWidget(
            label: "Ver Video",
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
