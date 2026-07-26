import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/labeled_field.dart';

/// Pay-bills form: pre-fills the category the user tapped from
/// [PaymentsScreen] (or defaults to a blank form when opened from the
/// home screen's "Pay Bills" quick action).
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
      appBar: const SecondaryAppBar(title: 'Pay bills'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledField(
                label: 'Biller / category',
                hint: 'e.g. Electricity, DSTV',
                prefixIcon: Iconsax.building,
                controller: _billerController,
              ),
              const SizedBox(height: AppSpacing.lg),
              LabeledField(
                label: 'Account / meter number',
                hint: 'Enter account number',
                prefixIcon: Iconsax.card,
                controller: _accountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppSpacing.lg),
              LabeledField(
                label: 'Amount',
                hint: '0.00',
                prefixText: '₦ ',
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'Pay now',
                icon: Iconsax.receipt_2,
                loading: _paying,
                onPressed: _pay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
