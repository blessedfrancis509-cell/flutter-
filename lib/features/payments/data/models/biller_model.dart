import 'package:flutter/material.dart';

class BillerCategoryModel {
  final String label;
  final IconData icon;
  final Color color;

  const BillerCategoryModel({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class SavedBillerModel {
  final String name;
  final String account;
  final IconData icon;
  final Color color;

  const SavedBillerModel({
    required this.name,
    required this.account,
    required this.icon,
    required this.color,
  });
}
