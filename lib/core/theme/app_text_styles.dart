import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography scale for ZenCash.
///
/// Uses **Inter** via Google Fonts. Every weight variant is defined as a
/// static getter so call-sites stay concise and consistent.
class AppTextStyles {
  AppTextStyles._();

  // ── Logo ───────────────────────────────────────────────────────────
  static TextStyle logo = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnDark,
    letterSpacing: -0.5,
  );

  // ── Screen titles ──────────────────────────────────────────────────
  static TextStyle screenTitle = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.4,
  );

  static TextStyle screenTitleLight = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnDark,
    letterSpacing: -0.4,
  );

  // ── Section headings ───────────────────────────────────────────────
  static TextStyle sectionTitle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static TextStyle sectionTitleLight = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnDark,
    letterSpacing: -0.2,
  );

  // ── Row titles ─────────────────────────────────────────────────────
  static TextStyle rowTitle = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle rowTitleLight = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnDark,
  );

  // ── Row subtitles / meta ───────────────────────────────────────────
  static TextStyle rowSubtitle = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle rowSubtitleLight = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnDarkMuted,
  );

  // ── Row values (right-aligned amounts) ─────────────────────────────
  static TextStyle rowValue = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle rowValueMuted = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  // ── Balance / big numbers ──────────────────────────────────────────
  static TextStyle balanceLarge = GoogleFonts.inter(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnDark,
    letterSpacing: -1.0,
    height: 1.1,
  );

  static TextStyle balanceLabel = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnDarkMuted,
    letterSpacing: 0.6,
  );

  // ── Quick-action labels ────────────────────────────────────────────
  static TextStyle quickActionLabel = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  // ── Buttons ────────────────────────────────────────────────────────
  static TextStyle buttonPrimary = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnDark,
    letterSpacing: 0.2,
  );

  static TextStyle buttonSecondary = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryPurple,
    letterSpacing: 0.2,
  );

  // ── Chips / tags ───────────────────────────────────────────────────
  static TextStyle chip = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryPurple,
  );

  // ── Hints inside text fields ───────────────────────────────────────
  static TextStyle fieldHint = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle fieldInput = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // ── Tab labels ─────────────────────────────────────────────────────
  static TextStyle tabLabel = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
}
