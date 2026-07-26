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
            SliverToBoxAdapter(
              child: _buildHeader(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
              sliver: SliverToBoxAdapter(
                child: Text('Saved beneficiaries', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  itemCount: _contacts.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, i) {
                    if (i == 0) return _addBeneficiaryButton(context);
                    final c = _contacts[i - 1];
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
                          Text(c.name, style: AppTextStyles.rowValueMuted.copyWith(fontSize: 11)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.sm),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent activity', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
                    Text('See all', style: AppTextStyles.rowValueMuted.copyWith(
                      color: AppColors.primaryPurple,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    )),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xxl),
              sliver: SliverList.separated(
                itemCount: _history.length,
                separatorBuilder: (_, __) => const SizedBox(height: 2),
                itemBuilder: (context, i) => _TransactionRow(model: _history[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryPurpleDeep, AppColors.primaryPurpleDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₦2,450.75',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Icon(
                      Iconsax.eye,
                      size: 19,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _HeaderAction(
                      icon: Iconsax.arrow_right_3,
                      label: 'Send',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SendMoneyScreen()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _HeaderAction(
                      icon: Iconsax.arrow_down,
                      label: 'Receive',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RequestMoneyScreen()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _HeaderAction(
                      icon: Iconsax.scan_barcode,
                      label: 'Scan QR',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ScanQrScreen()),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addBeneficiaryButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SendMoneyScreen()),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.10),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryPurple.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: const Icon(Iconsax.add, size: 20, color: AppColors.primaryPurple),
          ),
          const SizedBox(height: 6),
          Text('Add new', style: AppTextStyles.rowValueMuted.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HeaderAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, size: 17, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
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
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
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
