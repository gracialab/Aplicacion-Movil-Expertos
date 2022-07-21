import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/core/utils/capitalize_string.dart';
import 'package:mr_fix_expert/gui/widgets/activity_indicator.dart';
import 'package:mr_fix_expert/gui/widgets/button_notification.dart';
import 'package:mr_fix_expert/core/providers/purchase_provider.dart';
import 'package:mr_fix_expert/gui/views/sales_view/sales_widget_view/card_expandable_widget.dart';

import 'sales_controller.dart';
import 'sales_widget_view/footer_total_sales_widget.dart';

class SalesView extends StatefulWidget {
  const SalesView({Key? key}) : super(key: key);

  @override
  _SalesViewState createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView>
    with SingleTickerProviderStateMixin {
  late final SalesController _salesController;

  @override
  void initState() {
    _salesController = SalesController(context)..init(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _salesController.tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = context.watch<PurchaseProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: const Text("Ventas"),
        centerTitle: true,
        actions: const [ButtonNotification()],
        bottom: TabBar(
          padding: const EdgeInsets.only(bottom: paddingBottomAppBarTabs),
          isScrollable: true,
          onTap: (int index) => _salesController.getSalesByDate(index + 1),
          controller: _salesController.tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          labelStyle: const TextStyle(fontWeight: FontWeight.w700),
          tabs: List.generate(
            quantityMonths,
            (index) {
              final String month = Jiffy({"month": (index + 1)}).format("MMMM");

              return Tab(
                text: month.capitalize(),
              );
            },
          ),
        ),
      ),
      body: purchaseProvider.isLoading
          ? const ActivityIndicator()
          : TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _salesController.tabController,
              children: List.generate(
                quantityMonths,
                (index) {
                  final String month =
                      Jiffy({"month": (index + 1)}).format("MMMM");
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: purchaseProvider.mySales.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          itemBuilder: (context, index) => CardExpandablewidget(
                            purchase: purchaseProvider.mySales[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ),
                      ),
                      FooterTotalWidget(
                        currentMont: month.capitalize(),
                        totalSalesByMonth: purchaseProvider.totalSalesMyMonth,
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
