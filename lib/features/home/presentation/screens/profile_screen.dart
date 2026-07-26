import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import 'settings_screen.dart';

/// User profile / settings screen: avatar + name header, then a list of
/// account, security, and support menu entries.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _accountItems = [
    (Iconsax.user, 'Personal information'),
    (Iconsax.shield_tick, 'Security & privacy'),
    (Iconsax.notification, 'Notification preferences'),
    (Iconsax.card, 'Linked cards & accounts'),
  ];

  static const _supportItems = [
    (Iconsax.message_question, 'Help & support'),
    (Iconsax.document_text, 'Terms & policies'),
    (Iconsax.info_circle, 'About ZenCash'),
  ];

  void _handleTap(BuildContext context, String title) {
    if (title == 'Personal information' ||
        title == 'Security & privacy' ||
        title == 'Notification preferences' ||
        title == 'Linked cards & accounts') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const SecondaryAppBar(title: 'Profile'),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryPurpleLight, AppColors.primaryPurple],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      'AC',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Ada Chukwu', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: 2),
                  Text('ada.chukwu@zencash.app', style: AppTextStyles.rowSubtitle),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Account', style: AppTextStyles.sectionTitle.copyWith(fontSize: 14)),
            const SizedBox(height: AppSpacing.sm),
            _menuGroup(context, _accountItems),
            const SizedBox(height: AppSpacing.xl),
            Text('Support', style: AppTextStyles.sectionTitle.copyWith(fontSize: 14)),
            const SizedBox(height: AppSpacing.sm),
            _menuGroup(context, _supportItems),
            const SizedBox(height: AppSpacing.xl),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                boxShadow: const [
                  BoxShadow(color: AppColors.shadowSoft, blurRadius: 20, offset: Offset(0, 8)),
                ],
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
                leading: const Icon(Iconsax.logout, color: AppColors.zenithRed, size: 20),
                title: Text(
                  'Log out',
                  style: AppTextStyles.rowTitle.copyWith(color: AppColors.zenithRed),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuGroup(BuildContext context, List<(IconData, String)> items) {
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
                leading: Icon(items[i].$1, size: 20, color: AppColors.primaryPurple),
                title: Text(items[i].$2, style: AppTextStyles.rowTitle.copyWith(fontSize: 14)),
                trailing: const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.textMuted),
                onTap: () => _handleTap(context, items[i].$2),
              ),
            ),
        ],
      ),
    );
  }
}
