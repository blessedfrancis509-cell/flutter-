import 'dart:math';
import 'package:flutter/material.dart';

/// CustomPainter for the ZenCash balance card metallic / glass effect.
///
/// Paints a multi-layer chrome-like surface with:
/// • Deep gradient base
/// • Subtle inner-glow arc along the top
/// • Faint horizontal scan-line texture
/// • Metallic highlight shimmer at the top edge
class BalanceCardPainter extends CustomPainter {
  final Animation<double>? animation;

  BalanceCardPainter({this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // ── Base gradient ──────────────────────────────────────────────
    final basePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4A2D8A),
          Color(0xFF2E1760),
          Color(0xFF1A0D40),
          Color(0xFF0F0825),
        ],
        stops: [0.0, 0.35, 0.7, 1.0],
      ).createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(20)),
      basePaint,
    );

    // ── Top-edge metallic highlight ────────────────────────────────
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.22),
          Colors.white.withOpacity(0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.15, 0.4],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.5));
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(20)),
      highlightPaint,
    );

    // ── Inner glow arc (top) ──────────────────────────────────────
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.8),
        radius: 1.2,
        colors: [
          const Color(0xAA8B5CF6).withOpacity(0.25),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(20)),
      glowPaint,
    );

    // ── Subtle scan-line texture ───────────────────────────────────
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    for (double y = 0; y < size.height; y += 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // ── Bottom reflection band ─────────────────────────────────────
    final reflectPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white.withOpacity(0.06),
          Colors.transparent,
        ],
        stops: const [0.0, 0.25],
      ).createShader(Rect.fromLTWH(0, size.height * 0.6, size.width, size.height * 0.4));
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(20)),
      reflectPaint,
    );

    // ── Animated shimmer sweep ─────────────────────────────────────
    if (animation != null) {
      final t = animation!.value;
      final sweepX = -size.width * 0.3 + t * (size.width * 1.6);
      final shimmerPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(0.07),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(
          Rect.fromLTWH(sweepX - 60, 0, 120, size.height),
        );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(20)),
        shimmerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(BalanceCardPainter old) => true;
}
