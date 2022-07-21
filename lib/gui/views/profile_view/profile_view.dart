import 'package:flutter/material.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/gui/widgets/card_widget.dart';
import 'package:mr_fix_expert/gui/widgets/button_widget.dart';
import 'package:mr_fix_expert/data/models/items_profile.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix_expert/gui/widgets/button_notification.dart';

import 'profile_controller.dart';
import 'profile_widget_view/card_profile_widget.dart';

final List<ItemsProfileModel> optionsProfile = [
  ItemsProfileModel(
    icon: MaterialCommunityIcons.briefcase_outline,
    label: 'Mis especialidades',
    route: 'specialties',
  ),
  ItemsProfileModel(
    icon: Feather.file,
    label: 'Documentos legales',
    route: 'legal_document',
  ),
  ItemsProfileModel(
    icon: MaterialCommunityIcons.help_circle_outline,
    label: '¿Necesitas ayuda?',
    route: 'help_center',
  ),
];

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = ProfileController(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Perfil'),
        centerTitle: true,
        actions: [ButtonNotification()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CardProfile(
              stars: 5,
            ),
            const SizedBox(height: 20),
            CardWidget(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  optionsProfile.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: () => profileController
                          .redirectOptionSelect(optionsProfile[index].route),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            optionsProfile[index].icon,
                            color: Theme.of(context).colorScheme.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              optionsProfile[index].label,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
            ButtonWidget(
              label: "Cerrar Sesión",
              onTap: profileController.logout,
            ),
          ],
        ),
      ),
    );
  }
}
