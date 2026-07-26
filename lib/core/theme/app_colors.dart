import 'package:flutter/material.dart';

/// Centralised colour palette for the ZenCash app.
///
/// Premium banking palette: deep royal purples, champagne gold accents,
/// refined neutrals, and rich jewel-tone tints.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------
  // Brand purples — richer, deeper royal palette
  // ---------------------------------------------------------------------
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color primaryPurpleDark = Color(0xFF5B21B6);
  static const Color primaryPurpleDeep = Color(0xFF2E1065);
  static const Color primaryPurpleLight = Color(0xFFA78BFA);
  static const Color accentViolet = Color(0xFFC084FC);
  static const Color accentGold = Color(0xFFD4A853);
  static const Color accentGoldLight = Color(0xFFE8C97A);

  /// Header / top app-bar gradient — cinematic deep-to-rich purple.
  static const List<Color> headerGradient = [
    Color(0xFF1E0A3C),
    Color(0xFF3B0F7A),
    Color(0xFF6D28D9),
  ];

  /// Whole-screen background gradient.
  static const List<Color> screenGradient = [
    Color(0xFF0F0524),
    Color(0xFF1E0A3C),
    Color(0xFF3B1080),
  ];

  /// Balance / net-worth card gradient — premium dark chrome glass.
  static const List<Color> balanceCardGradient = [
    Color(0xFF3B2470),
    Color(0xFF251650),
    Color(0xFF160E35),
  ];

  static const Color balanceCardBorder = Color(0xFF9B8AD8);
  static const Color balanceCardInnerGlow = Color(0xAA8B5CF6);

  // ---------------------------------------------------------------------
  // Action buttons — richer greens
  // ---------------------------------------------------------------------
  static const Color sendGreen = Color(0xFF22C55E);
  static const Color sendGreenDark = Color(0xFF16A34A);
  static const Color glassButtonFill = Color(0x20FFFFFF);
  static const Color glassButtonBorder = Color(0x35FFFFFF);

  // ---------------------------------------------------------------------
  // Surfaces — warmer, softer whites
  // ---------------------------------------------------------------------
  static const Color scaffoldBackground = Color(0xFFF8F7FC);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color cardSurfaceAlt = Color(0xFFF5F3FA);
  static const Color dividerColor = Color(0xFFEDE9F4);

  // ---------------------------------------------------------------------
  // Text — deeper contrast
  // ---------------------------------------------------------------------
  static const Color textPrimary = Color(0xFF180836);
  static const Color textSecondary = Color(0xFF6B6580);
  static const Color textMuted = Color(0xFF9B95B0);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkMuted = Color(0xCCFFFFFF);
  static const Color textOnDarkFaint = Color(0x99FFFFFF);

  // ---------------------------------------------------------------------
  // Icon tint backgrounds (service rows) — jewel tones
  // ---------------------------------------------------------------------
  static const Color zenithRed = Color(0xFFEF4444);
  static const Color cardsPurple = Color(0xFF7C3AED);
  static const Color investGreen = Color(0xFF22C55E);
  static const Color businessNavy = Color(0xFF1E293B);

  // ---------------------------------------------------------------------
  // Bottom navigation
  // ---------------------------------------------------------------------
  static const Color navActive = Color(0xFF7C3AED);
  static const Color navInactive = Color(0xFFB4ADC6);
  static const Color navBackground = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------
  // Shadows — deeper, more dramatic
  // ---------------------------------------------------------------------
  static const Color shadowSoft = Color(0x14180836);
  static const Color shadowStrong = Color(0x28180836);
  static const Color glowPurple = Color(0x557C3AED);
  static const Color glowGold = Color(0x30D4A853);
}
