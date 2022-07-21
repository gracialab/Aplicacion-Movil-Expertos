import 'package:flutter/material.dart';

class ItemsProfileModel {
  ItemsProfileModel({
    required this.icon,
    required this.label,
    required this.route,
  });

  final String label;
  final String route;
  final IconData icon;
}
