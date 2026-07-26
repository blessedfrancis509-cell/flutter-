import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/biller_model.dart';
import 'pay_bills_screen.dart';

/// "Payments" bottom-nav tab: grid of biller categories, saved billers,
/// and a short recent-payments list.
class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  static const _categories = [
    BillerCategoryModel(label: 'Electricity', icon: Icons.bolt_rounded, color: AppColors.zenithRed),
    BillerCategoryModel(label: 'Internet', icon: Icons.wifi_rounded, color: AppColors.primaryPurple),
    BillerCategoryModel(label: 'TV', icon: Icons.tv_rounded, color: AppColors.businessNavy),
    BillerCategoryModel(label: 'Airtime', icon: Icons.phone_android_rounded, color: AppColors.investGreen),
    BillerCategoryModel(label: 'Water', icon: Icons.water_drop_rounded, color: Color(0xFF2196C4)),
    BillerCategoryModel(label: 'Education', icon: Icons.school_rounded, color: Color(0xFFB8860B)),
    BillerCategoryModel(label: 'Insurance', icon: Icons.shield_rounded, color: Color(0xFF6B2FD6)),
    BillerCategoryModel(label: 'More', icon: Icons.grid_view_rounded, color: AppColors.textMuted),
  ];

  static const _saved = [
    SavedBillerModel(name: 'Ikeja Electric', account: '••••4821', icon: Icons.bolt_rounded, color: AppColors.zenithRed),
    SavedBillerModel(name: 'Spectranet', account: '••••7790', icon: Icons.wifi_rounded, color: AppColors.primaryPurple),
    SavedBillerModel(name: 'DSTV', account: '••••1103', icon: Icons.tv_rounded, color: AppColors.businessNavy),
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
            Text('Payments', style: AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
            const SizedBox(height: AppSpacing.xl),
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
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PayBillsScreen(initialCategory: c.label)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: c.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Icon(c.icon, size: 22, color: c.color),
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
            Text('Saved billers', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
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
                  for (int i = 0; i < _saved.length; i++)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        border: i != _saved.length - 1
                            ? const Border(bottom: BorderSide(color: AppColors.dividerColor))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _saved[i].color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(AppRadius.xs),
                            ),
                            child: Icon(_saved[i].icon, size: 18, color: _saved[i].color),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_saved[i].name, style: AppTextStyles.rowTitle),
                                const SizedBox(height: 2),
                                Text(_saved[i].account, style: AppTextStyles.rowSubtitle),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PayBillsScreen(initialCategory: _saved[i].name),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPurple.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(AppRadius.pill),
                              ),
                              child: Text(
                                'Pay',
                                style: AppTextStyles.rowValueMuted.copyWith(
                                  color: AppColors.primaryPurple,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
