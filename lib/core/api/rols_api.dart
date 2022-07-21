import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/data/models/rols_model/rols_model.dart';

class RolsApi {
  final Logger _logger = Logger();
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('rols');

  Future<QuerySnapshot<RolModel>>? getRols() {
    try {
      return _firestore
          .where("name", isEqualTo: "expert")
          .withConverter<RolModel>(
              fromFirestore: (snapshot, _) =>
                  RolModel.fromJson(snapshot.data()!),
              toFirestore: (rol, _) => rol.toJson())
          .get();
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }
}
