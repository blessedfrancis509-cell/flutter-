import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'balance_card_painter.dart';

/// Premium glassmorphic balance card with metallic shimmer animation.
///
/// Uses [CustomPaint] with [BalanceCardPainter] for layered chrome effects
/// and wraps the content with subtle transparency.
class BalanceCard extends StatefulWidget {
  final String balance;
  final String label;
  final String accountNumber;

  const BalanceCard({
    super.key,
    this.balance = '\u20A62,450.75',
    this.label = 'Total Balance',
    this.accountNumber = '\u2022\u2022\u2022\u2022 4821',
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: AnimatedBuilder(
        animation: _shimmerCtrl,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowStrong,
                  blurRadius: 28,
                  offset: Offset(0, 12),
                ),
                BoxShadow(
                  color: AppColors.glowPurple,
                  blurRadius: 48,
                  offset: Offset(0, 16),
                  spreadRadius: -4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: CustomPaint(
                painter: BalanceCardPainter(animation: _shimmerCtrl),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 22),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.balanceCardBorder.withOpacity(0.25),
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopRow(),
                      const SizedBox(height: 16),
                      _buildBalanceRow(),
                      const SizedBox(height: 18),
                      _buildBottomRow(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.sendGreen,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.sendGreen,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: AppTextStyles.balanceLabel.copyWith(
                  color: AppColors.textOnDarkMuted,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Icon(
          Iconsax.eye_slash,
          size: 16,
          color: AppColors.textOnDarkMuted,
        ),
      ],
    );
  }

  Widget _buildBalanceRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(widget.balance, style: AppTextStyles.balanceLarge),
        const SizedBox(width: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.sendGreen.withOpacity(0.18),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.arrow_up_3, size: 11, color: AppColors.sendGreen),
                SizedBox(width: 2),
                Text(
                  '12.5%',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.sendGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Row(
      children: [
        Icon(Iconsax.card, size: 14, color: AppColors.textOnDarkFaint),
        const SizedBox(width: 6),
        Text(
          'Zenith Savings  ${widget.accountNumber}',
          style: AppTextStyles.rowSubtitleLight.copyWith(
            color: AppColors.textOnDarkFaint,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.accentGold.withOpacity(0.18),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: AppColors.accentGold.withOpacity(0.25),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.star_1, size: 10, color: AppColors.accentGold),
              SizedBox(width: 3),
              Text(
                'Premium',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentGold,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
