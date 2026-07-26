import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/investment_model.dart';

/// "Investments" bottom-nav tab: portfolio value header, a simple bar
/// visual for allocation, and a list of individual holdings.
class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  static const _holdings = [
    InvestmentModel(name: 'Zenith Money Market Fund', ticker: 'ZMMF', value: 850000, changePercent: 1.8, color: AppColors.primaryPurple),
    InvestmentModel(name: 'US Equity Index', ticker: 'USEQ', value: 420500, changePercent: 3.4, color: AppColors.investGreen),
    InvestmentModel(name: 'Nigerian T-Bills', ticker: 'NTB', value: 310200, changePercent: 0.6, color: AppColors.accentViolet),
    InvestmentModel(name: 'Global Bond Fund', ticker: 'GBF', value: 128900, changePercent: -0.9, color: AppColors.zenithRed),
  ];

  double get _total => _holdings.fold(0, (sum, h) => sum + h.value);

  @override
  Widget build(BuildContext context) {
    final total = _total;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xxl),
          children: [
            Text('Investments', style: AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4C3A78), Color(0xFF1B1638)],
                ),
                boxShadow: [
                  BoxShadow(color: AppColors.primaryPurple.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PORTFOLIO VALUE', style: AppTextStyles.balanceLabel),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '₦${_formatMoney(total)}',
                    style: AppTextStyles.balanceLarge.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(Iconsax.arrow_up_3, size: 14, color: AppColors.sendGreen),
                      const SizedBox(width: 4),
                      Text(
                        '+2.1% (₦18,240.00) this month',
                        style: AppTextStyles.rowValueMuted.copyWith(color: AppColors.sendGreen),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Allocation', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: SizedBox(
                height: 10,
                child: Row(
                  children: _holdings
                      .map((h) => Expanded(
                            flex: (h.value / total * 1000).round(),
                            child: Container(color: h.color),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Holdings', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
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
                  for (int i = 0; i < _holdings.length; i++)
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        border: i != _holdings.length - 1
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
                              color: _holdings[i].color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                            ),
                            child: Text(
                              _holdings[i].ticker.substring(0, 2),
                              style: AppTextStyles.rowValueMuted.copyWith(
                                color: _holdings[i].color,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_holdings[i].name, style: AppTextStyles.rowTitle),
                                const SizedBox(height: 2),
                                Text(_holdings[i].ticker, style: AppTextStyles.rowSubtitle),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('₦${_formatMoney(_holdings[i].value)}', style: AppTextStyles.rowValue),
                              const SizedBox(height: 2),
                              Text(
                                '${_holdings[i].isPositive ? '+' : ''}${_holdings[i].changePercent.toStringAsFixed(1)}%',
                                style: AppTextStyles.rowValueMuted.copyWith(
                                  color: _holdings[i].isPositive ? AppColors.investGreen : AppColors.zenithRed,
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
          ],
        ),
      ),
    );
  }

  String _formatMoney(double value) {
    final whole = value.floor();
    final cents = ((value - whole) * 100).round();
    final wholeStr = whole.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '$wholeStr.${cents.toString().padLeft(2, '0')}';
  }
}
