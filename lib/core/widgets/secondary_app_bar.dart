import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_constants.dart';

/// Consistent top bar for every non-home screen: a circular back button,
/// a centered title, and an optional trailing action.
class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final Color background;
  final Color foreground;

  const SecondaryAppBar({
    super.key,
    required this.title,
    this.trailing,
    this.background = AppColors.scaffoldBackground,
    this.foreground = AppColors.textPrimary,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: background,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leadingWidth: 64,
      leading: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.md),
        child: GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: foreground == AppColors.textPrimary
                  ? AppColors.cardSurfaceAlt
                  : Colors.white.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.arrow_left, size: 18, color: foreground),
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.sectionTitle.copyWith(color: foreground),
      ),
      actions: [
        if (trailing != null) trailing! else const SizedBox(width: 54),
      ],
    );
  }
}
