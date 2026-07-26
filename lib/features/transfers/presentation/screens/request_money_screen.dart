import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/labeled_field.dart';

/// Request-money flow: enter an amount + who it's from, generates a
/// shareable request link/QR (represented here as a summary card).
class RequestMoneyScreen extends StatefulWidget {
  const RequestMoneyScreen({super.key});

  @override
  State<RequestMoneyScreen> createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final _amountController = TextEditingController();
  final _fromController = TextEditingController();
  bool _generated = false;

  @override
  void dispose() {
    _amountController.dispose();
    _fromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const SecondaryAppBar(title: 'Request money'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledField(
                label: 'Amount',
                hint: '0.00',
                prefixText: '₦ ',
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: AppSpacing.lg),
              LabeledField(
                label: 'Request from',
                hint: 'Name, phone or email',
                prefixIcon: Iconsax.user,
                controller: _fromController,
              ),
              const SizedBox(height: AppSpacing.xxl),
              if (_generated) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: const [
                      BoxShadow(color: AppColors.shadowSoft, blurRadius: 18, offset: Offset(0, 8)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.cardSurfaceAlt,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Iconsax.tick_circle, size: 30, color: AppColors.investGreen),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        '₦${_amountController.text.isEmpty ? '0.00' : _amountController.text} requested',
                        style: AppTextStyles.rowTitle.copyWith(fontSize: 17),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'From ${_fromController.text.isEmpty ? 'recipient' : _fromController.text}',
                        style: AppTextStyles.rowSubtitle,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          'zencash.app/req/8f3k2',
                          style: AppTextStyles.rowValueMuted.copyWith(color: AppColors.primaryPurple),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              PrimaryButton(
                label: _generated ? 'Share request' : 'Generate request',
                icon: _generated ? Iconsax.share : Iconsax.arrow_swap,
                onPressed: () => setState(() => _generated = true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
