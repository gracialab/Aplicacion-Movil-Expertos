import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/core/api/purchase_api.dart';
import 'package:mr_fix_expert/core/paths/local_paths.dart';
import 'package:mr_fix_expert/gui/widgets/card_widget.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/gui/widgets/calendar_events.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/widgets/button_notification.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';
import 'package:mr_fix_expert/gui/views/home_view/home_controller.dart';

import 'home_widgets/card_service_assigned_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeController homeController;
  @override
  void initState() {
    super.initState();
    homeController = HomeController(context)..init();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: CustomAppBar(
        title: Image(
          image: AssetImage(LocalAppPaths.logoHeader),
          fit: BoxFit.contain,
          height: 80.0,
          width: 80.0,
        ),
        actions: const [ButtonNotification()],
        centerTitle: true,
      ),
      body: Column(
        children: [
          CalendarEvents(
            focusedDay: homeController.selected,
            onDaySelected: (DateTime selectDay, DateTime focusDay) =>
                homeController.onSelectedDate(selectDay, focusDay),
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: ColorsAppTheme.greyAppPalette[100],
              borderRadius: BorderRadius.circular(12),
            ),
            width: 40,
          ),
          currentUser == null
              ? const SizedBox()
              : _listAssignedServices(currentUser),
        ],
      ),
    );
  }

  Widget _listAssignedServices(UserModel currentUser) {
    return Expanded(
      child: ValueListenableBuilder<DateTime>(
        valueListenable: homeController.maxDate,
        builder: (ctx, value, _) => StreamBuilder<QuerySnapshot>(
          stream: PurchaseApi().getMyAssignedPurchases(
            status: [confirmedStatus, inProgressStatus],
            maxDate: value,
            userId: currentUser.reference,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const SizedBox();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ActivityIndicator();
            }

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: snapshot.data?.size ?? 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];

                final PurchaseModel purchase =
                    PurchaseModel.fromJson(doc.data()! as Map<String, dynamic>);
                return CardWidget(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 16,
                  ),
                  child: CardServiceAssigned(
                    purchase: purchase,
                    controller: homeController,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
