import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/core/config/app_constants.dart';
import 'package:mr_fix_expert/data/models/purchase/purchase_model.dart';

class PurchaseApi {
  final Logger logger = Logger();
  final CollectionReference _firestore = FirebaseFirestore.instance.collection('purchases');

  Stream<QuerySnapshot>? getPurchaseByStatusAndSpecialties(
    List<String> specialties,
    int status,
    DocumentReference? userId,
  ) {
    try {
      return _firestore
          .where("statusPurchase", isEqualTo: status)
          .where("expert", isEqualTo: userId)
          .where("service.id", whereIn: specialties)
          .orderBy('createAt', descending: true)
          .snapshots();
    } catch (e) {
      logger.e("getPurchaseByStatusAndSpecialties $e");
      return null;
    }
  }

  Stream<QuerySnapshot>? getMyAssignedPurchases({
    required List<int> status,
    required DateTime maxDate,
    required DocumentReference? userId,
  }) {
    try {
      return _firestore
          .where("expert", isEqualTo: userId)
          .where("statusPurchase", whereIn: status)
          .where("date", isEqualTo: maxDate)
          .orderBy('hour', descending: true)
          .snapshots();
    } catch (e) {
      logger.e("getMyAssignedPurchases $e");
      return null;
    }
  }

  Future<bool> updatePurchase(String id, PurchaseModel purchase) async {
    try {
      await _firestore.doc(id).update(purchase.toJson());
      return true;
    } catch (e) {
      logger.e("updatePurchase $e");
      return false;
    }
  }

  Future<QuerySnapshot>? getPurchasByRangeDate({
    required DateTime minDate,
    required DateTime maxDate,
    required DocumentReference? userId,
  }) {
    try {
      return _firestore
          .where("expert", isEqualTo: userId)
          .where("statusPayment", isEqualTo: paidStatus)
          .where("statusPurchase", isEqualTo: finishStatus)
          .where("date", isGreaterThanOrEqualTo: minDate)
          .where("date", isLessThanOrEqualTo: maxDate)
          .orderBy('date')
          .orderBy('createAt')
          .get();
    } catch (e) {
      logger.e("getPurchasByRangeDate $e");
      return null;
    }
  }
}
