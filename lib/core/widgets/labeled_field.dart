import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_constants.dart';

/// A labeled input field with a consistent light-grey pill style, used on
/// Send / Request / Pay Bills forms.
class LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? prefixText;

  const LabeledField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.rowSubtitle),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.cardSurfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.dividerColor),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTextStyles.rowTitle.copyWith(fontSize: 15),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.rowSubtitle,
              prefixText: prefixText,
              prefixStyle: AppTextStyles.rowTitle.copyWith(fontSize: 15),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, size: 18, color: AppColors.textSecondary)
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
