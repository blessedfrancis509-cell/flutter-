import 'package:flutter/material.dart';

/// Centralised colour palette for the ZenCash app.
///
/// All purples, gradients, shadows and neutrals used across the UI
/// are declared here so the rest of the app never hard-codes a colour.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------
  // Brand purples
  // ---------------------------------------------------------------------
  static const Color primaryPurple = Color(0xFF6B2FD6);
  static const Color primaryPurpleDark = Color(0xFF4B1F9E);
  static const Color primaryPurpleDeep = Color(0xFF2E1065);
  static const Color primaryPurpleLight = Color(0xFF8B5CF6);
  static const Color accentViolet = Color(0xFF9D5CFF);

  /// Header / top app-bar gradient (deep purple → violet).
  static const List<Color> headerGradient = [
    Color(0xFF3B0F7A),
    Color(0xFF6425C2),
    Color(0xFF7C3FE0),
  ];

  /// Whole-screen background gradient.
  static const List<Color> screenGradient = [
    Color(0xFF1B0742),
    Color(0xFF3B1080),
    Color(0xFF5B21B6),
  ];

  /// Balance / net-worth card gradient — dark chrome-purple glass.
  static const List<Color> balanceCardGradient = [
    Color(0xFF4C3A78),
    Color(0xFF2C2350),
    Color(0xFF1B1638),
  ];

  static const Color balanceCardBorder = Color(0xFF8E7CD4);
  static const Color balanceCardInnerGlow = Color(0x998B5CF6);

  // ---------------------------------------------------------------------
  // Action buttons
  // ---------------------------------------------------------------------
  static const Color sendGreen = Color(0xFF2ECC71);
  static const Color sendGreenDark = Color(0xFF1E9E58);
  static const Color glassButtonFill = Color(0x26FFFFFF); // white @ 15%
  static const Color glassButtonBorder = Color(0x40FFFFFF); // white @ 25%

  // ---------------------------------------------------------------------
  // Surfaces
  // ---------------------------------------------------------------------
  static const Color scaffoldBackground = Color(0xFFF4F3F8);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color cardSurfaceAlt = Color(0xFFF7F6FB);
  static const Color dividerColor = Color(0xFFEDEBF3);

  // ---------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------
  static const Color textPrimary = Color(0xFF1C1533);
  static const Color textSecondary = Color(0xFF6F6A85);
  static const Color textMuted = Color(0xFF9A96AC);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkMuted = Color(0xCCFFFFFF);
  static const Color textOnDarkFaint = Color(0x99FFFFFF);

  // ---------------------------------------------------------------------
  // Icon tint backgrounds (service rows)
  // ---------------------------------------------------------------------
  static const Color zenithRed = Color(0xFFE23F3F);
  static const Color cardsPurple = Color(0xFF6B2FD6);
  static const Color investGreen = Color(0xFF16A34A);
  static const Color businessNavy = Color(0xFF1E293B);

  // ---------------------------------------------------------------------
  // Bottom navigation
  // ---------------------------------------------------------------------
  static const Color navActive = Color(0xFF6B2FD6);
  static const Color navInactive = Color(0xFFACA8BC);
  static const Color navBackground = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------
  // Shadows
  // ---------------------------------------------------------------------
  static const Color shadowSoft = Color(0x1A1C1533);
  static const Color shadowStrong = Color(0x33150A33);
  static const Color glowPurple = Color(0x4D8B5CF6);
}
