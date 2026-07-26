import 'package:flutter/material.dart';

enum TransactionDirection { credit, debit }

class TransactionModel {
  final String title;
  final String subtitle;
  final double amount;
  final TransactionDirection direction;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  const TransactionModel({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.direction,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });
}

class ContactModel {
  final String initials;
  final String name;
  final Color avatarColor;

  const ContactModel({
    required this.initials,
    required this.name,
    required this.avatarColor,
  });
}
