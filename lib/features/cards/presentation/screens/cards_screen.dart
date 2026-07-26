import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/models/card_model.dart';

/// "Cards" bottom-nav tab: a swipeable card carousel, quick controls
/// (freeze, limits, details), and recent card transactions.
class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final _pageController = PageController(viewportFraction: 0.88);
  int _currentPage = 0;
  bool _frozen = false;

  static const _cards = [
    BankCardModel(
      holderName: 'Ada Chukwu',
      maskedNumber: '•••• •••• •••• 4821',
      expiry: '09/28',
      type: 'Debit Card',
      gradient: [Color(0xFF4C3A78), Color(0xFF1B1638)],
    ),
    BankCardModel(
      holderName: 'Ada Chukwu',
      maskedNumber: '•••• •••• •••• 7790',
      expiry: '02/27',
      type: 'Virtual Card',
      gradient: [Color(0xFF2ECC71), Color(0xFF14532D)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
              child: Text('Cards', style: AppTextStyles.sectionTitle.copyWith(fontSize: 22)),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 190,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _cards.length + 1,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) {
                  if (i == _cards.length) return _AddCardTile();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _CardTile(model: _cards[i], frozen: i == 0 && _frozen),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_cards.length + 1, (i) {
                final active = i == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primaryPurple : AppColors.dividerColor,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: _ControlButton(
                      icon: _frozen ? Iconsax.unlock : Iconsax.lock_1,
                      label: _frozen ? 'Unfreeze' : 'Freeze card',
                      onTap: () => setState(() => _frozen = !_frozen),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _ControlButton(icon: Iconsax.setting_4, label: 'Limits', onTap: () {}),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _ControlButton(icon: Iconsax.eye, label: 'Details', onTap: () {}),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
              child: Text('Card transactions', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  boxShadow: const [
                    BoxShadow(color: AppColors.shadowSoft, blurRadius: 20, offset: Offset(0, 8)),
                  ],
                ),
                child: Column(
                  children: [
                    _txRow('Netflix', 'Subscription • Today', '4,400.00', Iconsax.video_play, AppColors.zenithRed),
                    _txRow('Uber', 'Ride • Yesterday', '2,150.00', Iconsax.car, AppColors.businessNavy),
                    _txRow('Shoprite', 'Groceries • 2 days ago', '18,920.50', Iconsax.shopping_bag, AppColors.investGreen, showDivider: false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _txRow(String title, String subtitle, String amount, IconData icon, Color color, {bool showDivider = true}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: showDivider ? const Border(bottom: BorderSide(color: AppColors.dividerColor)) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.rowTitle),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.rowSubtitle),
              ],
            ),
          ),
          Text('-₦$amount', style: AppTextStyles.rowValue.copyWith(fontSize: 13.5)),
        ],
      ),
    );
  }
}

class _CardTile extends StatelessWidget {
  final BankCardModel model;
  final bool frozen;
  const _CardTile({required this.model, required this.frozen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: model.gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: model.gradient.last.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.type,
                    style: AppTextStyles.quickActionLabel.copyWith(color: Colors.white70),
                  ),
                  const Icon(Iconsax.wifi, size: 18, color: Colors.white70),
                ],
              ),
              const Spacer(),
              Text(
                model.maskedNumber,
                style: AppTextStyles.rowTitle.copyWith(
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.holderName, style: AppTextStyles.rowValueMuted.copyWith(color: Colors.white)),
                  Text('Exp ${model.expiry}', style: AppTextStyles.rowValueMuted.copyWith(color: Colors.white70)),
                ],
              ),
            ],
          ),
          if (frozen)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                alignment: Alignment.center,
                child: const Icon(Iconsax.lock_1, color: Colors.white, size: 28),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddCardTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardSurfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.dividerColor, width: 1.4),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColors.cardSurface, shape: BoxShape.circle),
              child: const Icon(Iconsax.add, size: 20, color: AppColors.primaryPurple),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('Add new card', style: AppTextStyles.rowValueMuted),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ControlButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: const [
            BoxShadow(color: AppColors.shadowSoft, blurRadius: 14, offset: Offset(0, 6)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: AppColors.primaryPurple),
            const SizedBox(height: 6),
            Text(label, style: AppTextStyles.rowValueMuted, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
