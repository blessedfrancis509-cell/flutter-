import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../data/models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final TransactionDirection direction;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  const TransactionDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.direction,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = direction == TransactionDirection.credit;
    final sign = isCredit ? '+' : '-';
    final amountStr = amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d)(?=\.))'),
          (m) => '${m[1]},',
        );

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const SecondaryAppBar(title: 'Transaction details'),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(icon, size: 28, color: iconColor),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Center(
              child: Text(
                '$sign₦$amountStr',
                style: AppTextStyles.balanceLarge.copyWith(
                  fontSize: 32,
                  color: isCredit ? AppColors.investGreen : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Center(
              child: Text(
                title,
                style: AppTextStyles.sectionTitle,
              ),
            ),
            const SizedBox(height: 2),
            Center(
              child: Text(
                subtitle,
                style: AppTextStyles.rowSubtitle,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                boxShadow: const [
                  BoxShadow(color: AppColors.shadowSoft, blurRadius: 20, offset: Offset(0, 8)),
                ],
              ),
              child: Column(
                children: [
                  _detailRow('Status', 'Completed', Iconsax.tick_circle, AppColors.investGreen),
                  _detailRow('Date', _extractDate(subtitle), Iconsax.calendar, AppColors.primaryPurple),
                  _detailRow('Transaction ID', 'TXN-${_generateId()}', Iconsax.document_copy, AppColors.businessNavy),
                  _detailRow('Type', isCredit ? 'Credit' : 'Debit', isCredit ? Iconsax.arrow_down : Iconsax.arrow_up_3, isCredit ? AppColors.investGreen : AppColors.zenithRed),
                  _detailRow('Account', 'Zenith ••4821', Iconsax.bank, AppColors.primaryPurple, showDivider: false),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: _actionButton('Share receipt', Iconsax.share, AppColors.primaryPurple),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _actionButton('Download PDF', Iconsax.document_download, AppColors.businessNavy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _extractDate(String subtitle) {
    if (subtitle.contains('Today')) return 'Today, ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';
    if (subtitle.contains('Yesterday')) return 'Yesterday, 14:32';
    if (subtitle.contains('days ago')) return 'Last week';
    return 'Recent';
  }

  String _generateId() {
    final now = DateTime.now();
    return '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';
  }

  Widget _detailRow(String label, String value, IconData icon, Color color, {bool showDivider = true}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: showDivider ? const Border(bottom: BorderSide(color: AppColors.dividerColor)) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(label, style: AppTextStyles.rowSubtitle),
          ),
          Text(value, style: AppTextStyles.rowValue.copyWith(fontSize: 13.5)),
        ],
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(label, style: AppTextStyles.rowValueMuted.copyWith(color: color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
