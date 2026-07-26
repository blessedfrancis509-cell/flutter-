import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Shared dimension tokens (radius, spacing, durations).
class AppConstants {
  AppConstants._();
}

/// Border radii.
class AppRadius {
  AppRadius._();
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double xxl = 32;
  static const double pill = 100;
}

/// Spacing scale (logical-pixel increments).
class AppSpacing {
  AppSpacing._();
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

/// Animation durations.
class AppDurations {
  AppDurations._();
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration press = Duration(milliseconds: 120);
  static const Duration entrance = Duration(milliseconds: 480);
  static const Duration stagger = Duration(milliseconds: 90);
  static const Duration shimmer = Duration(milliseconds: 1400);
  static const Duration glow = Duration(milliseconds: 2000);
}
