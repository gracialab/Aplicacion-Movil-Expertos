import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix_expert/core/api/user_api.dart';
import 'package:mr_fix_expert/data/models/user/user_model.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';

class MainController {
  late BuildContext _context;
  late FirebaseAuth _auth;
  late UserApi _userApi;
  late StreamSubscription<DocumentSnapshot<UserModel>>? streamUser;

  static final MainController _singleton = MainController._();
  factory MainController(BuildContext context) => _singleton._instancia(context);
  MainController._();

  MainController _instancia(BuildContext context) {
    _singleton._context = context;
    _singleton._userApi = UserApi();
    _singleton._auth = FirebaseAuth.instance;
    return _singleton;
  }

  void init() {
    getUser();
    notificationFirebase();
  }

  void getUser() {
    _userApi.getUser(_auth.currentUser!.uid).then((stream) {
      if (stream != null) {
        streamUser = stream.listen((user) {
          _context.read<UserProvider>().user = user.data()!.copyWith(
                reference: user.reference,
              );
        });
      }
    });
  }

  void notificationFirebase() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification: ${message.data}");
    });
  }

  void dispose() {
    streamUser?.cancel();
  }
}
