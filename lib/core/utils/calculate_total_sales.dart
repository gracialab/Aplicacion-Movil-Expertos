import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

int calculateTotalSales(List<PurchaseModel> purchases) {
  int total = 0;

  for (var purchase in purchases) {
    total += purchase.service.price;
  }

  return total;
}
