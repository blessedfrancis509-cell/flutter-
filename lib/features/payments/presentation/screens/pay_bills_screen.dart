import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';

class PayBillsScreen extends StatefulWidget {
  final String? initialCategory;
  const PayBillsScreen({super.key, this.initialCategory});

  @override
  State<PayBillsScreen> createState() => _PayBillsScreenState();
}

class _PayBillsScreenState extends State<PayBillsScreen> {
  late final TextEditingController _billerController;
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  bool _paying = false;

  @override
  void initState() {
    super.initState();
    _billerController = TextEditingController(text: widget.initialCategory ?? '');
  }

  @override
  void dispose() {
    _billerController.dispose();
    _accountController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    setState(() => _paying = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _paying = false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        title: const Text('Payment successful'),
        content: Text(
          '₦${_amountController.text.isEmpty ? '0.00' : _amountController.text} paid to '
          '${_billerController.text.isEmpty ? 'biller' : _billerController.text}.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: SecondaryAppBar(title: widget.initialCategory ?? 'Pay bills'),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBillerInput(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildAccountInput(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildAmountSection(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildBalanceInfo(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
              child: PrimaryButton(
                label: 'Pay now',
                icon: Iconsax.receipt_2,
                loading: _paying,
                onPressed: _pay,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillerInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: const [
          BoxShadow(color: AppColors.shadowSoft, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Iconsax.building, size: 18, color: AppColors.primaryPurple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _billerController,
              style: AppTextStyles.rowTitle.copyWith(fontSize: 14.5),
              decoration: InputDecoration(
                hintText: 'Biller / category',
                hintStyle: AppTextStyles.rowSubtitle.copyWith(fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Icon(Iconsax.arrow_down_3, size: 16, color: AppColors.textMuted),
        ],
      ),
    );
  }

  Widget _buildAccountInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: const [
          BoxShadow(color: AppColors.shadowSoft, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.businessNavy.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Iconsax.card, size: 18, color: AppColors.businessNavy),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _accountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppTextStyles.rowTitle.copyWith(fontSize: 14.5),
              decoration: InputDecoration(
                hintText: 'Account / meter number',
                hintStyle: AppTextStyles.rowSubtitle.copyWith(fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl, horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: const [
          BoxShadow(color: AppColors.shadowSoft, blurRadius: 16, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Amount',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '₦',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IntrinsicWidth(
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                  ],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                  ),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted.withOpacity(0.4),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _quickAmounts(),
        ],
      ),
    );
  }

  Widget _quickAmounts() {
    final amounts = ['1,000', '2,000', '5,000', '10,000'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: amounts.map((a) {
        return GestureDetector(
          onTap: () => setState(() => _amountController.text = a.replaceAll(',', '')),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: AppColors.primaryPurple.withOpacity(0.15),
                width: 0.5,
              ),
            ),
            child: Text(
              '₦$a',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBalanceInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: AppColors.primaryPurple.withOpacity(0.12),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Iconsax.wallet_3, size: 16, color: AppColors.primaryPurple),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paying from',
                  style: AppTextStyles.rowTitle.copyWith(fontSize: 12.5),
                ),
                const SizedBox(height: 1),
                Text(
                  'Checking • ₦2,450.75 available',
                  style: AppTextStyles.rowSubtitle.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
