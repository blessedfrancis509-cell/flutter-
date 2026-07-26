import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'pay_bills_screen.dart';
import 'airtime_data_screen.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  static const _categories = [
    _Category(label: 'Airtime', icon: Iconsax.call, color: AppColors.sendGreen, screen: 'airtime'),
    _Category(label: 'Data', icon: Iconsax.wifi, color: AppColors.primaryPurple, screen: 'data'),
    _Category(label: 'Electricity', icon: Icons.bolt_rounded, color: AppColors.zenithRed, screen: 'electricity'),
    _Category(label: 'Cable TV', icon: Icons.tv_rounded, color: AppColors.businessNavy, screen: 'tv'),
    _Category(label: 'Internet', icon: Icons.wifi_rounded, color: Color(0xFF2196C4), screen: 'internet'),
    _Category(label: 'Water', icon: Icons.water_drop_rounded, color: Color(0xFF0EA5E9), screen: 'water'),
    _Category(label: 'Education', icon: Icons.school_rounded, color: Color(0xFFB8860B), screen: 'education'),
    _Category(label: 'More', icon: Icons.grid_view_rounded, color: AppColors.textMuted, screen: 'more'),
  ];

  static const _recentPayments = [
    _RecentPayment(name: 'MTN Airtime', detail: '₦500 • Today', network: 'MTN', color: AppColors.mtnYellow),
    _RecentPayment(name: 'Ikeja Electric', detail: '₦12,500 • Yesterday', network: 'IKDC', color: AppColors.zenithRed),
    _RecentPayment(name: 'DSTV Premium', detail: '₦21,000 • 3 days ago', network: 'DSTV', color: AppColors.businessNavy),
    _RecentPayment(name: 'Spectranet', detail: '₦9,500 • 5 days ago', network: 'SPT', color: AppColors.primaryPurple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xxl),
          children: [
            _buildBalanceCard(),
            const SizedBox(height: AppSpacing.xl),
            Text('Services', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
            const SizedBox(height: AppSpacing.md),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, i) {
                final c = _categories[i];
                return GestureDetector(
                  onTap: () {
                    if (c.screen == 'airtime') {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AirtimeDataScreen(type: TopUpType.airtime)),
                      );
                    } else if (c.screen == 'data') {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AirtimeDataScreen(type: TopUpType.data)),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PayBillsScreen(initialCategory: c.label)),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: c.color.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(c.icon, size: 23, color: c.color),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        c.label,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.rowValueMuted.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent payments', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
                Text('See all', style: AppTextStyles.rowValueMuted.copyWith(
                  color: AppColors.primaryPurple,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                )),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...List.generate(_recentPayments.length, (i) {
              final p = _recentPayments[i];
              return Container(
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
                        color: p.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                      child: Text(
                        p.network.substring(0, p.network.length.clamp(0, 3)),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: p.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: AppTextStyles.rowTitle),
                          const SizedBox(height: 2),
                          Text(p.detail, style: AppTextStyles.rowSubtitle),
                        ],
                      ),
                    ),
                    Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.textMuted),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.lg),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wallet Balance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '₦2,450.75',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: Colors.white.withOpacity(0.10),
                width: 0.5,
              ),
            ),
            child: const Text(
              'Fund wallet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Category {
  final String label;
  final IconData icon;
  final Color color;
  final String screen;

  const _Category({
    required this.label,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

class _RecentPayment {
  final String name;
  final String detail;
  final String network;
  final Color color;

  const _RecentPayment({
    required this.name,
    required this.detail,
    required this.network,
    required this.color,
  });
}
