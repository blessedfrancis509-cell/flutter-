import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../transfers/presentation/screens/transfers_screen.dart';
import '../../../payments/presentation/screens/payments_screen.dart';
import '../../../cards/presentation/screens/cards_screen.dart';
import '../../../investments/presentation/screens/investments_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/home_tab.dart';

/// The ZenCash app's root tab container.
///
/// Owns the selected bottom-nav index and swaps between the five main
/// destinations — Home, Transfers, Payments, Cards, Investments — using
/// an [IndexedStack] so each tab's scroll position and state is preserved
/// when switching back and forth.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  static const _tabs = [
    HomeTab(),
    TransfersScreen(),
    PaymentsScreen(),
    CardsScreen(),
    InvestmentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: IndexedStack(index: _tabIndex, children: _tabs),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
      ),
    );
  }
}
