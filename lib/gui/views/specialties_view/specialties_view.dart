import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/core/api/service_api.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/data/models/service/service_model.dart';

import 'specialties_widgets/button_save_widget.dart';
import 'specialties_widgets/item_service_widget.dart';

class Specialties extends StatelessWidget {
  const Specialties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showGradient: true,
        title: Text('Especialidades'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ServiceApi().getServiceActive(),
        builder: (context, snapshotService) {
          if (snapshotService.hasError) {
            return const SizedBox();
          }

          if (snapshotService.connectionState == ConnectionState.waiting) {
            return const ActivityIndicator();
          }

          final List<QueryDocumentSnapshot?> docsServices = snapshotService.data?.docs ?? [];

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(thickness: 1.1),
            itemCount: docsServices.length,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              final ServiceModel service = ServiceModel.fromJson(
                docsServices[index]!.data()! as Map<String, dynamic>,
              ).copyWith(reference: docsServices[index]!.reference);

              return ItemService(service: service);
            },
          );
        },
      ),
      bottomNavigationBar: const ButtonSave(),
    );
  }
}
