import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/core/api/user_api.dart';
import 'package:mr_fix_expert/core/api/purchase_api.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/utils/calculate_total_sales.dart';
import 'package:mr_fix_expert/core/providers/purchase_provider.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

const int quantityMonths = 12;

class SalesController {
  late BuildContext _context;
  late TabController tabController;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final UserApi _userApi = UserApi();
  final PurchaseApi _purchaseApi = PurchaseApi();

  static final SalesController _singleton = SalesController._();
  factory SalesController(BuildContext context) =>
      _singleton._instancia(context);
  SalesController._();

  SalesController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void init(TickerProvider tickerProvider) {
    final currentMonth = DateTime.now();
    tabController = TabController(
      length: quantityMonths,
      vsync: tickerProvider,
      initialIndex: currentMonth.month - 1,
    );
    Future.microtask(() => getSalesByDate(currentMonth.month));
  }

  void getSalesByDate([int month = 0]) async {
    final purchaseProvider = _context.read<PurchaseProvider>();

    purchaseProvider.isLoading = true;

    late DocumentReference? reference;

    final userProvider = _context.read<UserProvider>();

    if (userProvider.user == null) {
      final user = firebaseAuth.currentUser!.uid;
      final userDetail = await _userApi.getUserDetail(user);
      reference = userDetail!.reference;
    } else {
      reference = userProvider.user!.reference;
    }

    final Jiffy _jiffy = Jiffy(
      {
        "month": month,
        "day": 1,
        "hour": 0,
        "minute": 0,
        "second": 0,
        "millisecond": 0,
      },
    );
    final DateTime minDate = _jiffy.dateTime;
    final DateTime maxDate = _jiffy.add(months: 1).subtract(days: 1).dateTime;

    final response = await _purchaseApi.getPurchasByRangeDate(
      minDate: minDate,
      maxDate: maxDate,
      userId: reference,
    );

    if (response != null && response.size > 0) {
      final listPurchases = response.docs
          .map(
            (e) => PurchaseModel.fromJson(
              (e.data() as Map<String, dynamic>),
            ),
          )
          .toList();
      final int totalSales = await compute(calculateTotalSales, listPurchases);

      purchaseProvider.mySales = listPurchases;
      purchaseProvider.totalSalesMyMonth = totalSales;
    } else {
      purchaseProvider.mySales = [];
      purchaseProvider.totalSalesMyMonth = 0;
    }
    purchaseProvider.isLoading = false;
  }
}
