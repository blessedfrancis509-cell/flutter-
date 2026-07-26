import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../data/models/transaction_model.dart';

/// Send-money flow: pick / enter a recipient, enter an amount and an
/// optional note, then confirm.
class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  int _selectedContact = 0;
  bool _sending = false;

  static const _contacts = [
    ContactModel(initials: 'TJ', name: 'Tunde', avatarColor: AppColors.cardsPurple),
    ContactModel(initials: 'AO', name: 'Amaka', avatarColor: AppColors.investGreen),
    ContactModel(initials: 'CE', name: 'Chidi', avatarColor: AppColors.zenithRed),
    ContactModel(initials: 'FB', name: 'Fatima', avatarColor: AppColors.accentViolet),
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _sending = false);
    final recipient = _contacts[_selectedContact].name;
    final amount = _amountController.text.isEmpty ? '0' : _amountController.text;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        title: const Text('Transfer sent'),
        content: Text('₦$amount sent to $recipient successfully.'),
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
      appBar: const SecondaryAppBar(title: 'Send money'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Send to', style: AppTextStyles.rowSubtitle),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 84,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _contacts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, i) {
                    final c = _contacts[i];
                    final selected = i == _selectedContact;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedContact = i),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selected ? AppColors.primaryPurple : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: c.avatarColor,
                              child: Text(
                                c.initials,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(c.name, style: AppTextStyles.rowValueMuted),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              LabeledField(
                label: 'Amount',
                hint: '0.00',
                prefixText: '₦ ',
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: AppSpacing.lg),
              LabeledField(
                label: 'Note (optional)',
                hint: "What's this for?",
                controller: _noteController,
                prefixIcon: Iconsax.edit_2,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.cardSurfaceAlt,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.wallet_2, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        'From Checking • ₦2,450.75 available',
                        style: AppTextStyles.rowSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'Send money',
                loading: _sending,
                icon: Iconsax.arrow_right_3,
                onPressed: _confirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
