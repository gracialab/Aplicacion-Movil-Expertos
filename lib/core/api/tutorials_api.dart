import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TutorialsApi {
  final Logger _logger = Logger();
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection("tutorials");

  Stream<QuerySnapshot>? getVideoTutorials() {
    try {
      return _firestore.where("active", isEqualTo: true).snapshots();
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }
}
