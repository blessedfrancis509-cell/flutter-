import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography scale for ZenCash — built on Google Fonts' Inter family.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _inter({
    required double size,
    required FontWeight weight,
    required Color color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // App bar
  static TextStyle logo = _inter(
    size: 20,
    weight: FontWeight.w800,
    color: AppColors.textOnDark,
    letterSpacing: -0.2,
  );

  // Balance card
  static TextStyle balanceLabel = _inter(
    size: 12.5,
    weight: FontWeight.w600,
    color: AppColors.textOnDarkMuted,
    letterSpacing: 1.1,
  );

  static TextStyle balanceAmount = _inter(
    size: 38,
    weight: FontWeight.w800,
    color: AppColors.textOnDark,
    letterSpacing: -0.5,
  );

  // Quick action labels
  static TextStyle quickActionLabel = _inter(
    size: 12.5,
    weight: FontWeight.w600,
    color: AppColors.textOnDarkMuted,
  );

  // Section titles
  static TextStyle sectionTitle = _inter(
    size: 17,
    weight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // Service / account rows
  static TextStyle rowTitle = _inter(
    size: 14.5,
    weight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle rowSubtitle = _inter(
    size: 13,
    weight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle rowValue = _inter(
    size: 13.5,
    weight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle rowValueMuted = _inter(
    size: 12.5,
    weight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  // Bottom nav
  static TextStyle navLabelActive = _inter(
    size: 11,
    weight: FontWeight.w700,
    color: AppColors.navActive,
  );

  static TextStyle navLabelInactive = _inter(
    size: 11,
    weight: FontWeight.w600,
    color: AppColors.navInactive,
  );

  // Status bar time
  static TextStyle statusBarTime = _inter(
    size: 14,
    weight: FontWeight.w700,
    color: AppColors.textOnDark,
  );
}
