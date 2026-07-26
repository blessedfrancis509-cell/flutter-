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

/// Row of four quick-action buttons — white background, simple icons.
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
            .map((a) => _QuickActionItem(
                  model: a,
                  onTap: () => _handleTap(context, a.label),
                ))
            .toList(growable: false),
      ),
    );
  }
}

class _QuickActionItem extends StatefulWidget {
  final QuickActionModel model;
  final VoidCallback onTap;
  const _QuickActionItem({required this.model, required this.onTap});

  @override
  State<_QuickActionItem> createState() => _QuickActionItemState();
}

class _QuickActionItemState extends State<_QuickActionItem> {
  double _scale = 1.0;

  void _setPressed(bool pressed) => setState(() => _scale = pressed ? 0.92 : 1.0);

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
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isPrimary
                    ? AppColors.primaryPurple
                    : AppColors.cardSurfaceAlt,
                borderRadius: BorderRadius.circular(14),
                boxShadow: isPrimary
                    ? [
                        BoxShadow(
                          color: AppColors.primaryPurple.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                widget.model.icon,
                color: isPrimary ? Colors.white : AppColors.primaryPurple,
                size: 22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.model.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
