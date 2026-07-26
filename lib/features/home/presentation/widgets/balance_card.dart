import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'balance_card_painter.dart';

/// The hero "Total Net Worth" card.
///
/// Layers (bottom → top):
///   1. Soft drop shadow behind the whole card.
///   2. Dark purple gradient base.
///   3. Frosted glass blur (BackdropFilter) for translucency.
///   4. Diagonal highlight sheen gradient overlay.
///   5. CustomPaint: metallic border + reflections + inner glow.
///   6. Foreground content (label, amount, eye toggle).
class BalanceCard extends StatefulWidget {
  final double amount;
  const BalanceCard({super.key, required this.amount});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _visible = true;

  String get _formattedAmount {
    final whole = widget.amount.floor();
    final cents = ((widget.amount - whole) * 100).round();
    final wholeStr = whole.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '₦$wholeStr.${cents.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const radius = AppRadius.xl;

    return Container(
      height: 148,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowStrong,
            blurRadius: 28,
            offset: const Offset(0, 18),
            spreadRadius: -6,
          ),
          BoxShadow(
            color: AppColors.glowPurple.withOpacity(0.35),
            blurRadius: 40,
            offset: const Offset(0, 8),
            spreadRadius: -14,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Base gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColors.balanceCardGradient,
                ),
              ),
            ),

            // Frosted glass blur layer
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                color: Colors.white.withOpacity(0.02),
              ),
            ),

            // Diagonal sheen overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.10),
                    Colors.transparent,
                    AppColors.primaryPurpleDeep.withOpacity(0.25),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),

            // Metallic border + reflections + inner glow
            Positioned.fill(
              child: CustomPaint(
                painter: BalanceCardPainter(borderRadius: radius),
              ),
            ),

            // Foreground content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _visible ? _formattedAmount : '₦ •••••••',
                    style: AppTextStyles.balanceAmount,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Text('TOTAL NET WORTH', style: AppTextStyles.balanceLabel),
                      const SizedBox(width: AppSpacing.xs),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => _visible = !_visible),
                        child: Icon(
                          _visible ? Iconsax.eye : Iconsax.eye_slash,
                          size: 15,
                          color: AppColors.textOnDarkMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
