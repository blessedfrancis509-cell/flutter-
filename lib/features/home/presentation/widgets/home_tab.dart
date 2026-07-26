import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import 'app_header.dart';
import 'balance_card.dart';
import 'quick_actions_row.dart';
import 'accounts_services_card.dart';

/// Home tab — clean gradient header that fades into a white scrollable body.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gradient header (not a Stack — just a Container at the top)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2D1066),
                Color(0xFF4C1D95),
                Color(0xFF6D28D9),
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
              child: Column(
                children: [
                  const AppHeader(),
                  const SizedBox(height: 24),
                  const BalanceCard(),
                ],
              ),
            ),
          ),
        ),

        // White body
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 20, bottom: 24),
            child: Column(
              children: const [
                QuickActionsRow(),
                SizedBox(height: 24),
                AccountsServicesCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
