import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelpCenterApi {
  final Logger _logger = Logger();
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection("helpCenter");

  Stream<QuerySnapshot>? getHelpCenter() {
    try {
      return _firestore.where("status", isEqualTo: true).snapshots();
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }
}
