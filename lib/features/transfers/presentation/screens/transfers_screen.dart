import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/transaction_model.dart';
import 'send_money_screen.dart';
import 'request_money_screen.dart';
import 'scan_qr_screen.dart';
import 'transaction_detail_screen.dart';

/// "Transfers" bottom-nav tab: quick contacts, Send/Request/Scan actions,
/// and a scrollable transaction history.
class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

  static const _contacts = [
    ContactModel(initials: 'TJ', name: 'Tunde', avatarColor: AppColors.cardsPurple),
    ContactModel(initials: 'AO', name: 'Amaka', avatarColor: AppColors.investGreen),
    ContactModel(initials: 'CE', name: 'Chidi', avatarColor: AppColors.zenithRed),
    ContactModel(initials: 'FB', name: 'Fatima', avatarColor: AppColors.accentViolet),
    ContactModel(initials: 'KP', name: 'Kemi', avatarColor: AppColors.businessNavy),
  ];

  static final _history = [
    TransactionModel(
      title: 'Tunde Johnson',
      subtitle: 'Transfer sent • Today',
      amount: 15000,
      direction: TransactionDirection.debit,
      icon: Iconsax.arrow_up_3,
      iconBackground: AppColors.zenithRed.withOpacity(0.12),
      iconColor: AppColors.zenithRed,
    ),
    TransactionModel(
      title: 'Amaka Obi',
      subtitle: 'Transfer received • Today',
      amount: 42000,
      direction: TransactionDirection.credit,
      icon: Iconsax.arrow_down,
      iconBackground: AppColors.investGreen.withOpacity(0.12),
      iconColor: AppColors.investGreen,
    ),
    TransactionModel(
      title: 'Chidi Eze',
      subtitle: 'Transfer sent • Yesterday',
      amount: 8500,
      direction: TransactionDirection.debit,
      icon: Iconsax.arrow_up_3,
      iconBackground: AppColors.zenithRed.withOpacity(0.12),
      iconColor: AppColors.zenithRed,
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
    TransactionModel(
      title: 'Fatima Bello',
      subtitle: 'Transfer sent • 4 days ago',
      amount: 12000,
      direction: TransactionDirection.debit,
      icon: Iconsax.arrow_up_3,
      iconBackground: AppColors.zenithRed.withOpacity(0.12),
      iconColor: AppColors.zenithRed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Text('Transfers', style: AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        icon: Iconsax.arrow_right_3,
                        label: 'Send',
                        color: AppColors.sendGreen,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SendMoneyScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _ActionCard(
                        icon: Iconsax.arrow_swap,
                        label: 'Request',
                        color: AppColors.primaryPurple,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const RequestMoneyScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _ActionCard(
                        icon: Iconsax.scan_barcode,
                        label: 'Scan QR',
                        color: AppColors.businessNavy,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ScanQrScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              sliver: SliverToBoxAdapter(
                child: Text('Quick contacts', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 84,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  itemCount: _contacts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, i) {
                    final c = _contacts[i];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SendMoneyScreen()),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: c.avatarColor,
                            child: Text(
                              c.initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(c.name, style: AppTextStyles.rowValueMuted),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              sliver: SliverToBoxAdapter(
                child: Text('Recent activity', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.xxl,
              ),
              sliver: SliverList.separated(
                itemCount: _history.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, i) => _TransactionRow(model: _history[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: const [
            BoxShadow(color: AppColors.shadowSoft, blurRadius: 14, offset: Offset(0, 6)),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: AppTextStyles.rowValueMuted),
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final TransactionModel model;
  const _TransactionRow({required this.model});

  @override
  Widget build(BuildContext context) {
    final isCredit = model.direction == TransactionDirection.credit;
    final sign = isCredit ? '+' : '-';
    final color = isCredit ? AppColors.investGreen : AppColors.textPrimary;
    final amountStr = model.amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d)(?=\.))'),
          (m) => '${m[1]},',
        );

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
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
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
          Text(
            '$sign₦$amountStr',
            style: AppTextStyles.rowValue.copyWith(color: color, fontSize: 13.5),
          ),
        ],
      ),
      ),
    );
  }
}
