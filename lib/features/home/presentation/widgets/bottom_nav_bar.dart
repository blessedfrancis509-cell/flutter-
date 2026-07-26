import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/account_service_model.dart';

/// Premium bottom navigation bar with pill-shaped active indicator and
/// subtle glow effect on the selected item.
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    NavItemModel(icon: Iconsax.home_2, activeIcon: Iconsax.home_2, label: 'Home'),
    NavItemModel(
      icon: Iconsax.arrow_swap_horizontal,
      activeIcon: Iconsax.arrow_swap_horizontal,
      label: 'Transfers',
    ),
    NavItemModel(
      icon: Iconsax.receipt_2,
      activeIcon: Iconsax.receipt_2,
      label: 'Payments',
    ),
    NavItemModel(icon: Iconsax.card, activeIcon: Iconsax.card, label: 'Cards'),
    NavItemModel(
      icon: Iconsax.chart_2,
      activeIcon: Iconsax.chart_2,
      label: 'Investments',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowStrong.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final selected = i == currentIndex;
              final item = _items[i];
              return _NavButton(
                item: item,
                selected: selected,
                onTap: () => onTap(i),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavItemModel item;
  final bool selected;
  final VoidCallback onTap;

  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryPurple.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                selected ? item.activeIcon : item.icon,
                key: ValueKey(selected),
                size: selected ? 23 : 21,
                color: selected ? AppColors.navActive : AppColors.navInactive,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: selected
                  ? AppTextStyles.tabLabel.copyWith(color: AppColors.navActive)
                  : AppTextStyles.tabLabel.copyWith(color: AppColors.navInactive),
            ),
          ],
        ),
      ),
    );
  }
}
