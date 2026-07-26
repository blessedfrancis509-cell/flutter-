import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
  final bool unread;

  const NotificationModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
    this.unread = false,
  });
}
