import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/core/api/purchase_api.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/widgets/button_notification.dart';

import 'services_widgets/list_services_widget.dart';

class ServicesHome extends StatelessWidget {
  const ServicesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserProvider>().user;
    return DefaultTabController(
      initialIndex: 0,
      length: listStatusPurchase.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          centerTitle: true,
          title: const Text('Servicios'),
          actions: const [
            ButtonNotification(),
          ],
          bottom: TabBar(
            padding: const EdgeInsets.only(bottom: paddingBottomAppBarTabs),
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: List.generate(
              listStatusPurchase.length,
              (index) => Tab(
                text: listStatusPurchase[index].label,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
            listStatusPurchase.length,
            (index) {
              final status = listStatusPurchase[index].value;

              if (currentUser == null) {
                return const SizedBox();
              }
              final List<String> specialties = currentUser.specialties?.map((e) => e.id).toList() ?? [];
              final DocumentReference? userId = index > 0 ? currentUser.reference : null;

              return StreamBuilder<QuerySnapshot>(
                stream: PurchaseApi().getPurchaseByStatusAndSpecialties(specialties, status, userId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SizedBox();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ActivityIndicator();
                  }

                  return ListServices(data: snapshot.data);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
