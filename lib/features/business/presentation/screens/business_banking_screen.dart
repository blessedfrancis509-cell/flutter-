import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';

/// Business Banking overview: business account balance and a set of
/// business-specific tools (invoicing, payroll, team cards, etc.).
class BusinessBankingScreen extends StatelessWidget {
  const BusinessBankingScreen({super.key});

  static const _tools = [
    ('Invoicing', Iconsax.document_text, AppColors.primaryPurple),
    ('Payroll', Iconsax.people, AppColors.investGreen),
    ('Team cards', Iconsax.card, AppColors.businessNavy),
    ('Tax reports', Iconsax.chart_2, AppColors.zenithRed),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const SecondaryAppBar(title: 'Business banking'),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                color: AppColors.businessNavy,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BUSINESS BALANCE', style: AppTextStyles.balanceLabel),
                  const SizedBox(height: AppSpacing.xs),
                  Text('₦1,284,600.00', style: AppTextStyles.balanceLarge.copyWith(fontSize: 28)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Zenith Business • Acct ••4930', style: AppTextStyles.rowValueMuted.copyWith(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Business tools', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
            const SizedBox(height: AppSpacing.sm),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tools.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, i) {
                final (label, icon, color) = _tools[i];
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
                      Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(AppRadius.xs),
                        ),
                        child: Icon(icon, size: 16, color: color),
                      ),
                      const Spacer(),
                      Text(label, style: AppTextStyles.rowTitle.copyWith(fontSize: 13)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
