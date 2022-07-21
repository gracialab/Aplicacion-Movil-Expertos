import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/gui/widgets/card_widget.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';

import 'avatar_profile_view.dart';

class CardProfile extends StatelessWidget {
  final int? stars;
  const CardProfile({Key? key, this.stars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const starBorder = Icon(
      Icons.star_border,
      size: 18,
      color: ColorsAppTheme.primaryColor,
    );

    const star = Icon(
      Icons.star,
      size: 15,
      color: ColorsAppTheme.primaryColor,
    );

    final UserModel? user = context.watch<UserProvider>().user;
    return CardWidget(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Column(
              children: [
                const AvatarProfile(),
                const SizedBox(height: 3),
                Text(
                  "Puntuación",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsAppTheme.greyAppPalette,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    star,
                    star,
                    star,
                    star,
                    starBorder,
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _information(
                  title: 'Nombre y Apellido',
                  subTitle: "${user?.firtsName} ${user?.lastName}",
                ),
                _information(
                  title: 'Teléfono',
                  subTitle: user?.cellPhone ?? '',
                ),
                _information(
                  title: 'Correo',
                  subTitle: user?.email ?? '',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _information({
    required String title,
    required String subTitle,
  }) =>
      Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
}
