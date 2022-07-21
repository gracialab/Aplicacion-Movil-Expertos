import 'dart:io';

import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';

class UserApi {
  final Logger logger = Logger();
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

  Future<bool> createUser(UserModel user) async {
    try {
      await _firestore.doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<DocumentSnapshot<UserModel>?>? getUserDetail(String id) async {
    try {
      return _firestore
          .doc(id)
          .withConverter<UserModel>(
              fromFirestore: (snapshot, _) =>
                  UserModel.fromJson(snapshot.data()!),
              toFirestore: (user, _) => user.toJson())
          .get();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<Stream<DocumentSnapshot<UserModel>>?> getUser(String id) async {
    try {
      return _firestore
          .doc(id)
          .withConverter<UserModel>(
              fromFirestore: (snapshot, _) =>
                  UserModel.fromJson(snapshot.data()!),
              toFirestore: (user, _) => user.toJson())
          .snapshots();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      await _firestore.doc(user.id).update(user.toJson());
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<String?> uploadPhoto(File file, String idUser) async {
    try {
      TaskSnapshot response = await FirebaseStorage.instance
          .ref('userPhotos/$idUser')
          .putFile(file);

      return response.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      logger.e("Upload file: $e");
      return null;
    }
  }

  Future<bool?> deletePhoto(String imagUrl) async {
    try {
      FirebaseStorage.instance.refFromURL(imagUrl).delete();
      return true;
    } on FirebaseException catch (e) {
      logger.e("delete image: $e");
      return false;
    }
  }
}
