import 'package:flutter/material.dart';
import 'package:mr_fix_expert/core/providers/documents_and_help_center_provider.dart';
import 'package:mr_fix_expert/gui/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class DocumentsOrHelpView extends StatelessWidget {
  const DocumentsOrHelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documents = context.watch<DocumentsAndHelpCenterProvider>();
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          documents.document!.title,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(
          documents.document!.description,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
