import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/account_service_model.dart';

/// Clean bottom navigation bar — simple icons, purple active indicator dot.
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
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
        border: Border(
          top: BorderSide(color: AppColors.dividerColor, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              return _NavButton(
                item: _items[i],
                selected: i == currentIndex,
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
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? item.activeIcon : item.icon,
              size: 22,
              color: selected ? AppColors.navActive : AppColors.navInactive,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? AppColors.navActive : AppColors.navInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
