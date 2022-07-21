import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MetadataApi {
  final Logger logger = Logger();
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('metadata');

  Future<DocumentSnapshot?> getMetadataByKey(String key) async {
    try {
      return _firestore.doc(key).get();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
