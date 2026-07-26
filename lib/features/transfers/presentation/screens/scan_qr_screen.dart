import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// Scan-QR screen. Since there's no camera plugin wired up in this UI-only
/// project, the viewfinder is represented with a dark mock backdrop and an
/// animated scan-line — swap the backdrop for a `MobileScanner`/`CameraX`
/// preview when integrating a real scanner package.
class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF120A26), Color(0xFF000000)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Container(
                          width: 38,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Iconsax.close_circle, size: 18, color: Colors.white),
                        ),
                      ),
                      Text('Scan to pay', style: AppTextStyles.rowTitle.copyWith(color: Colors.white)),
                      Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Iconsax.flash_1, size: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 260,
                      height: 260,
                      child: Stack(
                        children: [
                          _cornerFrame(),
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, _) {
                              return Positioned(
                                top: _controller.value * 240,
                                left: 8,
                                right: 8,
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.accentViolet.withOpacity(0),
                                        AppColors.accentViolet,
                                        AppColors.accentViolet.withOpacity(0),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                  child: Text(
                    'Point your camera at a ZenCash QR code',
                    style: AppTextStyles.rowSubtitle.copyWith(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cornerFrame() {
    const side = 32.0;
    const thickness = 3.0;
    final color = Colors.white.withOpacity(0.9);

    Widget corner({required Alignment alignment}) {
      final isTop = alignment.y < 0;
      final isLeft = alignment.x < 0;
      return Align(
        alignment: alignment,
        child: Container(
          width: side,
          height: side,
          decoration: BoxDecoration(
            border: Border(
              top: isTop ? BorderSide(color: color, width: thickness) : BorderSide.none,
              bottom: !isTop ? BorderSide(color: color, width: thickness) : BorderSide.none,
              left: isLeft ? BorderSide(color: color, width: thickness) : BorderSide.none,
              right: !isLeft ? BorderSide(color: color, width: thickness) : BorderSide.none,
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        corner(alignment: Alignment.topLeft),
        corner(alignment: Alignment.topRight),
        corner(alignment: Alignment.bottomLeft),
        corner(alignment: Alignment.bottomRight),
      ],
    );
  }
}
