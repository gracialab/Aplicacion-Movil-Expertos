import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/gui/widgets/button_widget.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';

import '../specialties_controller.dart';

class ButtonSave extends StatelessWidget {
  const ButtonSave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<UserProvider>().isLoadingUpdateProfile;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, paddingBottom),
      child: isLoading
          ? const SizedBox(
              height: 55,
              child: ActivityIndicator(),
            )
          : ButtonWidget(
              label: 'Guardar',
              height: 55,
              onTap: SpecialtiesController(context).saveSpecialties,
            ),
    );
  }
}
