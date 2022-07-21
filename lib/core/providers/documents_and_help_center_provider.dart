import 'package:flutter/material.dart';
import 'package:mr_fix_expert/data/models/documents_and_help_center/documents_and_help_center_model.dart';

class DocumentsAndHelpCenterProvider with ChangeNotifier {
  bool _isLoading = false;

  LegalDocumentsAndHelpCenterModel? _document;

  LegalDocumentsAndHelpCenterModel? get document => _document;

  set document(LegalDocumentsAndHelpCenterModel? document) {
    _document = document;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
