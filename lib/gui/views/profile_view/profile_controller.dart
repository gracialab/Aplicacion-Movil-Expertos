import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/utils/hooks/use_navigation.dart';

class ProfileController {
  late BuildContext _context;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static final ProfileController _singleton = ProfileController._();
  factory ProfileController(BuildContext context) =>
      _singleton._instancia(context);
  ProfileController._();

  ProfileController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void redirectOptionSelect(String route) {
    if (route.isNotEmpty) {
      useNavigatePushName(_context, route);
    }
  }

  void logout() {
    _auth.signOut();
    useNavigateReplacePage(_context, '/');
  }
}
