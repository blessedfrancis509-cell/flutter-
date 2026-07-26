import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/account_service_model.dart';

/// A single tappable row inside the "My Accounts & Services" card, e.g.
/// "Zenith Accounts" with Checking/Savings sub-lines, or "Investments".
class AccountServiceTile extends StatefulWidget {
  final AccountServiceModel model;
  final bool showDivider;
  final VoidCallback? onTap;

  const AccountServiceTile({
    super.key,
    required this.model,
    this.showDivider = true,
    this.onTap,
  });

  @override
  State<AccountServiceTile> createState() => _AccountServiceTileState();
}

class _AccountServiceTileState extends State<AccountServiceTile> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    final m = widget.model;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _opacity = 0.6),
      onTapUp: (_) => setState(() => _opacity = 1.0),
      onTapCancel: () => setState(() => _opacity = 1.0),
      onTap: widget.onTap,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: AppDurations.press,
        child: Container(
          decoration: BoxDecoration(
            border: widget.showDivider
                ? const Border(
                    bottom: BorderSide(color: AppColors.dividerColor, width: 1),
                  )
                : null,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.lg,
          ),
          child: Row(
            crossAxisAlignment: m.lines.isEmpty
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: m.iconBackground,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: Icon(m.icon, size: 18, color: m.iconColor),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(m.title, style: AppTextStyles.rowTitle),
                        ),
                        const Icon(
                          Iconsax.arrow_right_3,
                          size: 15,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                    if (m.lines.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      ...m.lines.map(
                        (line) => Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(line.label, style: AppTextStyles.rowSubtitle),
                              Text(line.value, style: AppTextStyles.rowValue),
                            ],
                          ),
                        ),
                      ),
                    ] else if (m.trailingLabel != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(m.trailingLabel!, style: AppTextStyles.rowSubtitle),
                          Text(
                            m.trailingValue ?? '',
                            style: AppTextStyles.rowValueMuted,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
