import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/core/api/tutorials_api.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/widgets/button_notification.dart';
import 'package:mr_fix_expert/data/models/tutorials_model/tutorials_model.dart';
import 'package:mr_fix_expert/gui/views/tutorial_view/tutorial_controller.dart';
import 'package:mr_fix_expert/gui/views/tutorial_view/tutorial_widget/card_video_tutorial.dart';

class TutorialView extends StatelessWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Tutoriales"),
        centerTitle: true,
        actions: [ButtonNotification()],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: TutorialsApi().getVideoTutorials(),
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
            separatorBuilder: (context, index) => const SizedBox(),
            itemBuilder: (context, index) {
              final TutorialModel tutorial = TutorialModel.fromJson(
                  docs[index].data() as Map<String, dynamic>);
              return CardVideoTutorial(
                link: tutorial.link,
                title: tutorial.title,
                description: tutorial.description,
                onTap: () =>
                    TutorialController(context).openLink(tutorial.link),
              );
            },
          );
        },
      ),
    );
  }
}
