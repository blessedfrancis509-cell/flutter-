import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../screens/notifications_screen.dart';
import '../screens/profile_screen.dart';

/// Clean header bar — greeting on left, icon buttons on right.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Greeting
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Ada Chukwu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const Spacer(),
        _HeaderIconButton(
          icon: Iconsax.notification,
          showDot: true,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          ),
        ),
        const SizedBox(width: 10),
        _HeaderIconButton(
          icon: Iconsax.user,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          ),
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatefulWidget {
  final IconData icon;
  final bool showDot;
  final VoidCallback? onTap;
  const _HeaderIconButton({required this.icon, this.showDot = false, this.onTap});

  @override
  State<_HeaderIconButton> createState() => _HeaderIconButtonState();
}

class _HeaderIconButtonState extends State<_HeaderIconButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.9),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0x1FFFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(widget.icon, color: Colors.white, size: 20),
              if (widget.showDot)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.sendGreen,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF4C1D95),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
