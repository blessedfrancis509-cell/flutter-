import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../transfers/presentation/screens/send_money_screen.dart';
import '../../../transfers/presentation/screens/request_money_screen.dart';
import '../../../transfers/presentation/screens/scan_qr_screen.dart';
import '../../../payments/presentation/screens/pay_bills_screen.dart';
import '../../data/models/account_service_model.dart';

/// Row of four quick-action buttons. "Send" is highlighted in green;
/// the rest are frosted glass buttons. Larger, glowier, more premium.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  static const _actions = [
    QuickActionModel(icon: Iconsax.arrow_right_3, label: 'Send', isPrimary: true),
    QuickActionModel(icon: Iconsax.arrow_swap, label: 'Request'),
    QuickActionModel(icon: Iconsax.scan_barcode, label: 'Scan QR'),
    QuickActionModel(icon: Iconsax.receipt_2, label: 'Pay Bills'),
  ];

  void _handleTap(BuildContext context, String label) {
    late final Widget screen;
    switch (label) {
      case 'Send':
        screen = const SendMoneyScreen();
        break;
      case 'Request':
        screen = const RequestMoneyScreen();
        break;
      case 'Scan QR':
        screen = const ScanQrScreen();
        break;
      case 'Pay Bills':
      default:
        screen = const PayBillsScreen();
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _actions
            .map((a) => _QuickActionButton(
                  model: a,
                  onTap: () => _handleTap(context, a.label),
                ))
            .toList(growable: false),
      ),
    );
  }
}

class _QuickActionButton extends StatefulWidget {
  final QuickActionModel model;
  final VoidCallback onTap;
  const _QuickActionButton({required this.model, required this.onTap});

  @override
  State<_QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<_QuickActionButton> {
  double _scale = 1.0;

  void _setPressed(bool pressed) => setState(() => _scale = pressed ? 0.90 : 1.0);

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.model.isPrimary;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: AppDurations.press,
        curve: Curves.easeOut,
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isPrimary
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.sendGreen, AppColors.sendGreenDark],
                      )
                    : null,
                color: isPrimary ? null : AppColors.glassButtonFill,
                border: isPrimary
                    ? null
                    : Border.all(color: AppColors.glassButtonBorder, width: 1),
                boxShadow: isPrimary
                    ? [
                        BoxShadow(
                          color: AppColors.sendGreen.withOpacity(0.50),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: AppColors.sendGreen.withOpacity(0.15),
                          blurRadius: 36,
                          offset: const Offset(0, 12),
                          spreadRadius: -4,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Icon(
                widget.model.icon,
                color: Colors.white,
                size: 23,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(widget.model.label, style: AppTextStyles.quickActionLabel),
          ],
        ),
      ),
    );
  }
}
