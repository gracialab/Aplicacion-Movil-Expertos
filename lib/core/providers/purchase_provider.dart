import 'package:flutter/material.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

class PurchaseProvider with ChangeNotifier {
  bool _isLoading = false;
  int _totalSalesMyMonth = 0;
  PurchaseModel? _selectedPurchase;
  List<PurchaseModel> _mySales = [];

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  int get totalSalesMyMonth => _totalSalesMyMonth;

  set totalSalesMyMonth(int totalSalesMyMonth) {
    _totalSalesMyMonth = totalSalesMyMonth;
    notifyListeners();
  }

  List<PurchaseModel> get mySales => _mySales;

  set mySales(List<PurchaseModel> mySales) {
    _mySales = mySales;
    notifyListeners();
  }

  PurchaseModel? get selectedPurchase => _selectedPurchase;

  set selectedPurchase(PurchaseModel? selectedPurchase) {
    _selectedPurchase = selectedPurchase;
    notifyListeners();
  }
}
