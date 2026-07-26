import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/models/transaction_model.dart';

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
    ContactModel(initials: 'KP', name: 'Kemi', avatarColor: AppColors.businessNavy),
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select recipient', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 88,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _contacts.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                        itemBuilder: (context, i) {
                          if (i == 0) return _addContactButton();
                          final c = _contacts[i - 1];
                          final selected = (i - 1) == _selectedContact;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedContact = i - 1),
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
                                Text(
                                  c.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                    color: selected ? AppColors.primaryPurple : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    _buildAmountSection(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildNoteField(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildBalanceInfo(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
              child: PrimaryButton(
                label: 'Continue',
                loading: _sending,
                icon: Iconsax.arrow_right_3,
                onPressed: _confirm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl, horizontal: AppSpacing.lg),
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
            'Enter amount',
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
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '₦',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 28,
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
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                  ),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted.withOpacity(0.4),
                      fontSize: 40,
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
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cardSurfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.wallet_2, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  'From Checking • ₦2,450.75',
                  style: AppTextStyles.rowSubtitle.copyWith(fontSize: 11.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
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

  Widget _buildNoteField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: const [
          BoxShadow(color: AppColors.shadowSoft, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Iconsax.edit_2, size: 18, color: AppColors.textMuted),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: _noteController,
              style: AppTextStyles.rowTitle.copyWith(fontSize: 14),
              decoration: InputDecoration(
                hintText: "What's this for?",
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

  Widget _buildBalanceInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.investGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: AppColors.investGreen.withOpacity(0.15),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.investGreen.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Iconsax.info_circle, size: 16, color: AppColors.investGreen),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transfer fee',
                  style: AppTextStyles.rowTitle.copyWith(fontSize: 12.5),
                ),
                const SizedBox(height: 1),
                Text(
                  'Free for ZenCash to ZenCash transfers',
                  style: AppTextStyles.rowSubtitle.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            '₦0.00',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.investGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addContactButton() {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.10),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryPurple.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: const Icon(Iconsax.user_add, size: 18, color: AppColors.primaryPurple),
          ),
          const SizedBox(height: 6),
          Text('Add new', style: AppTextStyles.rowValueMuted.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}
