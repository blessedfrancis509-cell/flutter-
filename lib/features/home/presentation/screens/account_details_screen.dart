import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../../transfers/data/models/transaction_model.dart';
import '../../../transfers/presentation/screens/transaction_detail_screen.dart';

/// Drill-down details for the "Zenith Accounts" row: Checking / Savings
/// balances plus their combined recent transaction history.
class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  static final _transactions = [
    TransactionModel(
      title: 'Grocery run',
      subtitle: 'Card payment • Today',
      amount: 12400,
      direction: TransactionDirection.debit,
      icon: Iconsax.shopping_bag,
      iconBackground: AppColors.zenithRed.withOpacity(0.12),
      iconColor: AppColors.zenithRed,
    ),
    TransactionModel(
      title: 'Interest credit',
      subtitle: 'Savings • Today',
      amount: 640,
      direction: TransactionDirection.credit,
      icon: Iconsax.wallet_2,
      iconBackground: AppColors.investGreen.withOpacity(0.12),
      iconColor: AppColors.investGreen,
    ),
    TransactionModel(
      title: 'Salary — Zenith Corp',
      subtitle: 'Transfer received • 3 days ago',
      amount: 380000,
      direction: TransactionDirection.credit,
      icon: Iconsax.arrow_down,
      iconBackground: AppColors.investGreen.withOpacity(0.12),
      iconColor: AppColors.investGreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const SecondaryAppBar(title: 'Zenith Accounts'),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(
              children: [
                Expanded(child: _balanceCard('Checking', '₦2,450.75', AppColors.primaryPurple)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _balanceCard('Savings', '₦2,450.30', AppColors.investGreen)),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Recent transactions', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
            const SizedBox(height: AppSpacing.sm),
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
                  for (int i = 0; i < _transactions.length; i++)
                    _row(_transactions[i], showDivider: i != _transactions.length - 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceCard(String label, String amount, Color accent) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: const [
          BoxShadow(color: AppColors.shadowSoft, blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
          const SizedBox(height: AppSpacing.sm),
          Text(label, style: AppTextStyles.rowSubtitle),
          const SizedBox(height: 4),
          Text(amount, style: AppTextStyles.rowTitle.copyWith(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _row(TransactionModel model, {required bool showDivider}) {
    final isCredit = model.direction == TransactionDirection.credit;
    final sign = isCredit ? '+' : '-';
    final color = isCredit ? AppColors.investGreen : AppColors.textPrimary;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TransactionDetailScreen(
            title: model.title,
            subtitle: model.subtitle,
            amount: model.amount,
            direction: model.direction,
            icon: model.icon,
            iconBackground: model.iconBackground,
            iconColor: model.iconColor,
          ),
        ),
      ),
      child: Container(
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
              color: model.iconBackground,
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: Icon(model.icon, size: 18, color: model.iconColor),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.title, style: AppTextStyles.rowTitle),
                const SizedBox(height: 2),
                Text(model.subtitle, style: AppTextStyles.rowSubtitle),
              ],
            ),
          ),
          Text('$sign₦${model.amount.toStringAsFixed(2)}', style: AppTextStyles.rowValue.copyWith(color: color, fontSize: 13.5)),
        ],
      ),
      ),
    );
  }
}
