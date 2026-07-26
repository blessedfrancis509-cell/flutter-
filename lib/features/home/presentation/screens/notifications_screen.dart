import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../data/models/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _notifications = [
    NotificationModel(
      title: 'Transfer received',
      subtitle: 'Amaka Obi sent you ₦42,000.00',
      time: '2m ago',
      icon: Iconsax.arrow_down,
      color: AppColors.investGreen,
      unread: true,
    ),
    NotificationModel(
      title: 'Card payment',
      subtitle: 'Netflix subscription charged ₦4,400.00',
      time: '1h ago',
      icon: Iconsax.card,
      color: AppColors.zenithRed,
      unread: true,
    ),
    NotificationModel(
      title: 'Security alert',
      subtitle: 'New device signed in from Lagos, NG',
      time: '5h ago',
      icon: Iconsax.shield_tick,
      color: AppColors.primaryPurple,
    ),
    NotificationModel(
      title: 'Bill reminder',
      subtitle: 'Ikeja Electric bill due in 3 days',
      time: 'Yesterday',
      icon: Iconsax.receipt_2,
      color: AppColors.businessNavy,
    ),
    NotificationModel(
      title: 'Investment update',
      subtitle: 'Your portfolio is up 2.1% this month',
      time: '2 days ago',
      icon: Iconsax.chart_2,
      color: AppColors.investGreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const SecondaryAppBar(title: 'Notifications'),
      body: SafeArea(
        top: false,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: _notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, i) {
            final n = _notifications[i];
            return Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: n.unread ? Border.all(color: AppColors.primaryPurple.withOpacity(0.25)) : null,
                boxShadow: const [
                  BoxShadow(color: AppColors.shadowSoft, blurRadius: 14, offset: Offset(0, 6)),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: n.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                    ),
                    child: Icon(n.icon, size: 18, color: n.color),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(n.title, style: AppTextStyles.rowTitle)),
                            if (n.unread)
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(color: AppColors.sendGreen, shape: BoxShape.circle),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(n.subtitle, style: AppTextStyles.rowSubtitle),
                        const SizedBox(height: 4),
                        Text(n.time, style: AppTextStyles.rowValueMuted.copyWith(color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
