import 'package:flutter/material.dart';

useNavigatePushName(BuildContext context, String route) {
  Navigator.of(context).pushNamed(route);
}

useNavigatePop(BuildContext context) {
  Navigator.of(context).pop();
}

useNavigateReplaceName(BuildContext context, String route) {
  Navigator.of(context).pushReplacementNamed(route);
}

useNavigateReplacePage(BuildContext context, String route) {
  Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
}
