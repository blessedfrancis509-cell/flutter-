import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// Clean, modern balance card — solid gradient, no effects.
/// Looks like a real bank card (Revolut / Monzo / Kuda style).
class BalanceCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6D28D9),
              Color(0xFF4C1D95),
              Color(0xFF3B0F7A),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.30),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopRow(),
            const SizedBox(height: 20),
            _buildBalance(),
            const SizedBox(height: 20),
            _buildBottomRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const Spacer(),
        const Icon(
          Iconsax.eye_slash,
          size: 18,
          color: Color(0xCCFFFFFF),
        ),
      ],
    );
  }

  Widget _buildBalance() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          balance,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.arrow_up_3, size: 12, color: Color(0xFF86EFAC)),
                SizedBox(width: 3),
                Text(
                  '12.5%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF86EFAC),
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
        const Icon(Iconsax.card, size: 16, color: Color(0x99FFFFFF)),
        const SizedBox(width: 6),
        Text(
          'Zenith Savings  $accountNumber',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0x99FFFFFF),
          ),
        ),
      ],
    );
  }
}
