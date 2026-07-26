import 'package:flutter/material.dart';

/// A single sub-line inside an account row, e.g. "Checking — ₦2,450.75".
class AccountLine {
  final String label;
  final String value;
  const AccountLine({required this.label, required this.value});
}

/// A row inside the "My Accounts & Services" card.
class AccountServiceModel {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final List<AccountLine> lines;
  final String? trailingLabel;
  final String? trailingValue;

  const AccountServiceModel({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    this.lines = const [],
    this.trailingLabel,
    this.trailingValue,
  });
}

/// A quick-action button (Send / Request / Scan QR / Pay Bills).
class QuickActionModel {
  final IconData icon;
  final String label;
  final bool isPrimary;
  const QuickActionModel({
    required this.icon,
    required this.label,
    this.isPrimary = false,
  });
}

/// A bottom navigation destination.
class NavItemModel {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const NavItemModel({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
