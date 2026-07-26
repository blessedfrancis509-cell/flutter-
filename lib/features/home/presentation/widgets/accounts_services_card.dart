import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../cards/presentation/screens/cards_screen.dart';
import '../../../investments/presentation/screens/investments_screen.dart';
import '../../../business/presentation/screens/business_banking_screen.dart';
import '../../data/models/account_service_model.dart';
import '../screens/account_details_screen.dart';
import 'account_service_tile.dart';

/// White rounded card titled "My Accounts & Services" holding a list of
/// [AccountServiceTile]s. Sits below the balance card / quick actions and
/// scrolls with the rest of the page content. Each row navigates to its
/// corresponding detail screen.
class AccountsServicesCard extends StatelessWidget {
  const AccountsServicesCard({super.key});

  static final List<AccountServiceModel> _items = [
    AccountServiceModel(
      icon: Iconsax.bank,
      iconBackground: AppColors.zenithRed.withOpacity(0.12),
      iconColor: AppColors.zenithRed,
      title: 'Zenith Accounts',
      lines: const [
        AccountLine(label: 'Checking', value: '₦2,450.75'),
        AccountLine(label: 'Savings', value: '₦2,450.30'),
      ],
    ),
    AccountServiceModel(
      icon: Iconsax.card,
      iconBackground: AppColors.cardsPurple.withOpacity(0.12),
      iconColor: AppColors.cardsPurple,
      title: 'Zenith Cards',
      trailingLabel: 'Linked debit cards',
      trailingValue: 'Debit Card',
    ),
    AccountServiceModel(
      icon: Iconsax.chart_2,
      iconBackground: AppColors.investGreen.withOpacity(0.12),
      iconColor: AppColors.investGreen,
      title: 'Investments',
    ),
    AccountServiceModel(
      icon: Iconsax.briefcase,
      iconBackground: AppColors.businessNavy.withOpacity(0.10),
      iconColor: AppColors.businessNavy,
      title: 'Business Banking',
    ),
  ];

  void _handleTap(BuildContext context, String title) {
    late final Widget screen;
    switch (title) {
      case 'Zenith Accounts':
        screen = const AccountDetailsScreen();
        break;
      case 'Zenith Cards':
        screen = const CardsScreen();
        break;
      case 'Investments':
        screen = const InvestmentsScreen();
        break;
      case 'Business Banking':
      default:
        screen = const BusinessBankingScreen();
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSoft,
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Text('My Accounts & Services', style: AppTextStyles.sectionTitle),
          ),
          for (int i = 0; i < _items.length; i++)
            AccountServiceTile(
              model: _items[i],
              showDivider: i != _items.length - 1,
              onTap: () => _handleTap(context, _items[i].title),
            ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}
