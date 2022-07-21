import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_navigation.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.watch<UserProvider>().user;
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: ColorsAppTheme.greyAppPalette[100],
          backgroundImage: NetworkImage(
            user?.photo ?? '',
          ),
          radius: 50,
        ),
        Positioned(
          top: 5,
          right: -2,
          child: GestureDetector(
            onTap: () => useNavigatePushName(context, 'edit_profile'),
            child: _icon(context),
          ),
        )
      ],
    );
  }

  Widget _icon(BuildContext context) => Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          Feather.edit_2,
          color: Theme.of(context).colorScheme.primary,
          size: 16,
        ),
      );
}
