import 'package:flutter/material.dart';
import 'package:mr_fix_expert/gui/templates/main_template.dart';
import 'package:mr_fix_expert/gui/views/information_documents_or_help_view/documents_or_help_view.dart';
import 'package:mr_fix_expert/gui/views/login_view/login_view.dart';
import 'package:mr_fix_expert/gui/views/register_view/register_view.dart';
import 'package:mr_fix_expert/gui/views/specialties_view/specialties_view.dart';
import 'package:mr_fix_expert/gui/views/help_center_view/help_center_view.dart';
import 'package:mr_fix_expert/gui/views/edit_profile_view/edit_profile_view.dart';
import 'package:mr_fix_expert/gui/views/legal_document_view/legal_docu_view.dart';
import 'package:mr_fix_expert/gui/views/notifications_view/notification_view.dart';
import 'package:mr_fix_expert/gui/views/code_security_view/code_security_view.dart';
import 'package:mr_fix_expert/gui/views/password_recovery_view/password_recovery_view.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routesMap = {
      '/': MaterialPageRoute(
        builder: (_) => const LoginView(),
      ),
      'passRecovery': MaterialPageRoute(
        builder: (_) => const PasswordRecoeryView(),
      ),
      'notification': MaterialPageRoute(
        builder: (_) => const NotificationView(),
      ),
      'documentsView': MaterialPageRoute(
        builder: (_) => const DocumentsOrHelpView(),
      ),
      'main': MaterialPageRoute(
        builder: (_) => const MainTemplate(),
      ),
      'legal_document': MaterialPageRoute(
        builder: (_) => const LegalDocumentView(),
      ),
      'help_center': MaterialPageRoute(
        builder: (_) => const HelpCenterView(),
      ),
      'codeqr': MaterialPageRoute(
        builder: (_) => const CodeSecurityView(),
      ),
      'register': MaterialPageRoute(
        builder: (_) => const RegisterView(),
      ),
      'edit_profile': MaterialPageRoute(
        builder: (_) => const EditProfile(),
      ),
      'specialties': MaterialPageRoute(
        builder: (_) => const Specialties(),
      ),
    };
    return routesMap[settings.name!] ?? routesMap['/']!;
  }
}
