import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Paints the metallic bevel border, diagonal light reflections and the
/// soft inner glow that sit on top of the balance card's blurred glass
/// background. Kept as a dedicated painter so [BalanceCard] can layer it
/// inside a [CustomPaint] without cluttering the widget tree.
class BalanceCardPainter extends CustomPainter {
  final double borderRadius;

  BalanceCardPainter({this.borderRadius = 24});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    // 1) Faceted metallic border (bevelled chrome look).
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFCFC4F2),
          Color(0xFF8E7CD4),
          Color(0xFF6247A8),
          Color(0xFFB6A8E8),
        ],
        stops: [0.0, 0.35, 0.7, 1.0],
      ).createShader(rect);
    canvas.drawRRect(rrect.deflate(0.8), borderPaint);

    // 2) Diagonal glossy reflection band (top-left to mid).
    final reflectionPath = Path()
      ..moveTo(0, size.height * 0.05)
      ..lineTo(size.width * 0.42, 0)
      ..lineTo(size.width * 0.62, 0)
      ..lineTo(size.width * 0.12, size.height * 0.55)
      ..close();

    canvas.save();
    canvas.clipRRect(rrect);
    final reflectionPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.16),
          Colors.white.withOpacity(0.02),
        ],
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawPath(reflectionPath, reflectionPaint);

    // 3) Secondary thin highlight streak (bottom-right).
    final streakPath = Path()
      ..moveTo(size.width * 0.78, size.height)
      ..lineTo(size.width, size.height * 0.7)
      ..lineTo(size.width, size.height * 0.82)
      ..lineTo(size.width * 0.9, size.height)
      ..close();
    final streakPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(streakPath, streakPaint);
    canvas.restore();

    // 4) Inner glow ring just inside the border for depth.
    final innerGlowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = AppColors.balanceCardInnerGlow.withOpacity(0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawRRect(rrect.deflate(4), innerGlowPaint);
  }

  @override
  bool shouldRepaint(covariant BalanceCardPainter oldDelegate) =>
      oldDelegate.borderRadius != borderRadius;
}
