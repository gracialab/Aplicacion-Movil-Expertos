import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialController {
  late BuildContext _context;

  static final TutorialController _singleton = TutorialController._();
  factory TutorialController(BuildContext context) =>
      _singleton._instancia(context);
  TutorialController._();

  TutorialController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void openLink(String url) async {
    if (!await launch(url)) throw "Could not launch $url";
  }
}
