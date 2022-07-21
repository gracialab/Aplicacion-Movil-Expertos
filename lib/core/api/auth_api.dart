import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  final Logger logger = Logger();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(
    String email,
    String password,
  ) {
    return _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => value)
        .catchError((onError) {
      logger.e("SignIn $onError");
    });
  }

  Future<UserCredential?> createAccount(
    String email,
    String password,
  ) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => value)
        .catchError((onError) {
      logger.e("createAccount $onError");
    });
  }
}
