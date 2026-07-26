import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import 'app_header.dart';
import 'balance_card.dart';
import 'quick_actions_row.dart';
import 'accounts_services_card.dart';

/// Home tab with a cinematic gradient header and staggered entrance animations.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cinematic gradient header — taller for a grander feel
        Container(
          height: 370,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.headerGradient,
            ),
          ),
        ),

        // Subtle radial glow behind the balance card area
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 0.9,
                colors: [
                  AppColors.accentViolet.withOpacity(0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              const AppHeader(),
              const SizedBox(height: AppSpacing.xl),
              _AnimatedEntrance(
                delay: 0,
                child: const BalanceCard(),
              ),
              const SizedBox(height: AppSpacing.xl),
              _AnimatedEntrance(
                delay: 1,
                child: const QuickActionsRow(),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                  child: _AnimatedEntrance(
                    delay: 2,
                    child: const AccountsServicesCard(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Staggered fade + slide-up entrance animation.
class _AnimatedEntrance extends StatefulWidget {
  final Widget child;
  final int delay;
  const _AnimatedEntrance({required this.child, required this.delay});

  @override
  State<_AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<_AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.entrance,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(AppDurations.stagger * widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
