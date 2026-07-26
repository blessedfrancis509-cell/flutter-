import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import 'app_header.dart';
import 'balance_card.dart';
import 'quick_actions_row.dart';
import 'accounts_services_card.dart';

/// The "Home" tab content: purple gradient header block containing the
/// app bar, balance card and quick actions, followed by a scrollable
/// white "My Accounts & Services" card. Extracted from [HomeScreen] so it
/// can sit inside the tabbed [IndexedStack] alongside the other bottom-nav
/// destinations.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple gradient header block
        Container(
          height: 340,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.headerGradient,
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
                child: const BalanceCard(amount: 2450.75),
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

/// Small fade + slide-up entrance animation used to stagger the page's
/// primary sections on first build.
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
