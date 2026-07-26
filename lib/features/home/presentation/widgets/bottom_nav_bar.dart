import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/account_service_model.dart';

/// Bottom navigation bar with Home / Transfers / Payments / Cards /
/// Investments — active item shown in solid purple with bold icon.
///
/// Externally controlled: the parent owns the selected tab index (so it
/// can drive an [IndexedStack] of the corresponding screens) and passes
/// it in via [currentIndex] / [onTap].
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // NOTE: We intentionally reuse the same glyph for `icon` and `activeIcon`
  // and differentiate the selected state purely by colour (matching the
  // reference design, where the active tab is simply tinted purple).
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
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
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
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? item.activeIcon : item.icon,
              size: 22,
              color: selected ? AppColors.navActive : AppColors.navInactive,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: selected
                  ? AppTextStyles.navLabelActive
                  : AppTextStyles.navLabelInactive,
            ),
          ],
        ),
      ),
    );
  }
}
