import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const SecondaryAppBar(title: 'Settings'),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _sectionHeader('Account'),
            _menuGroup([
              _SettingItem(Iconsax.user, 'Personal information', 'Name, email, phone'),
              _SettingItem(Iconsax.shield_tick, 'Security', 'PIN, biometrics, 2FA'),
              _SettingItem(Iconsax.notification, 'Notifications', 'Push, email, SMS'),
              _SettingItem(Iconsax.language_square, 'Language', 'English'),
            ]),
            const SizedBox(height: AppSpacing.xl),
            _sectionHeader('Payment preferences'),
            _menuGroup([
              _SettingItem(Iconsax.bank, 'Default account', 'Checking ••4821'),
              _SettingItem(Iconsax.card, 'Linked cards', '2 cards linked'),
              _SettingItem(Iconsax.money_recive, 'Auto-pay', 'Manage recurring'),
              _SettingItem(Iconsax.global, 'Currency', 'NGN (₦)'),
            ]),
            const SizedBox(height: AppSpacing.xl),
            _sectionHeader('App'),
            _menuGroup([
              _SettingItem(Iconsax.moon, 'Dark mode', 'Off'),
              _SettingItem(Iconsax.document_text, 'Legal', 'Terms, privacy'),
              _SettingItem(Iconsax.info_circle, 'About', 'Version 1.0.0'),
            ]),
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: Text(
                'ZenCash v1.0.0 • Build 2026.07',
                style: AppTextStyles.rowValueMuted.copyWith(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: AppTextStyles.sectionTitle.copyWith(fontSize: 14),
      ),
    );
  }

  Widget _menuGroup(List<_SettingItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: const [
          BoxShadow(color: AppColors.shadowSoft, blurRadius: 20, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++)
            Container(
              decoration: BoxDecoration(
                border: i != items.length - 1
                    ? const Border(bottom: BorderSide(color: AppColors.dividerColor))
                    : null,
              ),
              child: ListTile(
                leading: Icon(items[i].icon, size: 20, color: AppColors.primaryPurple),
                title: Text(items[i].title, style: AppTextStyles.rowTitle.copyWith(fontSize: 14)),
                subtitle: Text(items[i].subtitle, style: AppTextStyles.rowSubtitle),
                trailing: const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.textMuted),
                onTap: () {},
              ),
            ),
        ],
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String title;
  final String subtitle;
  const _SettingItem(this.icon, this.title, this.subtitle);
}
