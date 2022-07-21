import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/core/api/help_center_api.dart';
import 'package:mr_fix_expert/gui/widgets/card_information.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/views/legal_document_view/legal_documents_controller.dart';
import 'package:mr_fix_expert/data/models/documents_and_help_center/documents_and_help_center_model.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Centro de ayuda"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: HelpCenterApi().getHelpCenter(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ActivityIndicator();
          }

          final List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              final LegalDocumentsAndHelpCenterModel document =
                  LegalDocumentsAndHelpCenterModel.fromJson(
                      docs[index].data() as Map<String, dynamic>);
              return CardInformationWidget(
                title: document.title,
                label: document.description,
                data:
                    Jiffy(document.createdAt.toString()).format("dd MMMM yyy"),
                onTap: () =>
                    LegalDocumentsController(context).detailDocument(document),
              );
            },
          );
        },
      ),
    );
  }
}
