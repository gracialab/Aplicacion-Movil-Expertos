import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceApi {
  final Logger logger = Logger();
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('services');

  Stream<QuerySnapshot>? getServiceActive() {
    try {
      return _firestore.where("active", isEqualTo: true).snapshots();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
