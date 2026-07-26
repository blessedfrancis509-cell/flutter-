import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/secondary_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';

enum TopUpType { airtime, data }

class AirtimeDataScreen extends StatefulWidget {
  final TopUpType type;
  const AirtimeDataScreen({super.key, this.type = TopUpType.airtime});

  @override
  State<AirtimeDataScreen> createState() => _AirtimeDataScreenState();
}

class _AirtimeDataScreenState extends State<AirtimeDataScreen> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  int _selectedNetwork = 0;
  bool _buying = false;

  bool get _isData => widget.type == TopUpType.data;

  static const _networks = [
    _Network(name: 'MTN', color: AppColors.mtnYellow, textColor: Color(0xFF1A1A1A)),
    _Network(name: 'GLO', color: AppColors.gloGreen, textColor: Colors.white),
    _Network(name: 'Airtel', color: AppColors.airtelRed, textColor: Colors.white),
    _Network(name: '9Mobile', color: AppColors.nineMobileGreen, textColor: Colors.white),
  ];

  static const _dataPlans = [
    _DataPlan(label: '100MB', price: '₦100', validity: '1 day'),
    _DataPlan(label: '500MB', price: '₦300', validity: '7 days'),
    _DataPlan(label: '1GB', price: '₦500', validity: '30 days'),
    _DataPlan(label: '2GB', price: '₦1,000', validity: '30 days'),
    _DataPlan(label: '5GB', price: '₦2,000', validity: '30 days'),
    _DataPlan(label: '10GB', price: '₦3,500', validity: '30 days'),
  ];

  int _selectedPlan = -1;

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _buy() async {
    setState(() => _buying = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _buying = false);
    final network = _networks[_selectedNetwork].name;
    final phone = _phoneController.text.isEmpty ? '08012345678' : _phoneController.text;
    final detail = _isData
        ? '${_dataPlans[_selectedPlan].label} data'
        : '₦${_amountController.text.isEmpty ? '0' : _amountController.text} airtime';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        title: Text(_isData ? 'Data purchased' : 'Airtime purchased'),
        content: Text('$detail sent to $phone on $network successfully.'),
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
      appBar: SecondaryAppBar(title: _isData ? 'Buy data' : 'Buy airtime'),
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
                    _buildNetworkSelector(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildPhoneInput(),
                    const SizedBox(height: AppSpacing.lg),
                    if (_isData) ...[
                      _buildDataPlans(),
                    ] else ...[
                      _buildAmountSection(),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    _buildBalanceInfo(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
              child: PrimaryButton(
                label: _isData ? 'Buy data' : 'Buy airtime',
                loading: _buying,
                icon: Iconsax.flash_1,
                onPressed: _buy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select network', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: List.generate(_networks.length, (i) {
            final n = _networks[i];
            final selected = i == _selectedNetwork;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedNetwork = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: i < _networks.length - 1 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: selected ? n.color : AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? n.color : AppColors.dividerColor,
                      width: selected ? 2 : 1,
                    ),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: n.color.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.white.withOpacity(0.25)
                              : n.color.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            n.name[0],
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: selected ? n.textColor : n.color,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n.name,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: selected ? n.textColor : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _networks[_selectedNetwork].color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _networks[_selectedNetwork].name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _networks[_selectedNetwork].color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppTextStyles.rowTitle.copyWith(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: AppTextStyles.rowSubtitle.copyWith(fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Icon(Iconsax.user, size: 18, color: AppColors.textMuted),
        ],
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
    final amounts = ['100', '200', '500', '1,000'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: amounts.map((a) {
        return GestureDetector(
          onTap: () => setState(() => _amountController.text = a.replaceAll(',', '')),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _networks[_selectedNetwork].color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: _networks[_selectedNetwork].color.withOpacity(0.20),
                width: 0.5,
              ),
            ),
            child: Text(
              '₦$a',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _networks[_selectedNetwork].color,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDataPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select a plan', style: AppTextStyles.sectionTitle.copyWith(fontSize: 15)),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _dataPlans.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, i) {
            final p = _dataPlans[i];
            final selected = i == _selectedPlan;
            final nColor = _networks[_selectedNetwork].color;
            return GestureDetector(
              onTap: () => setState(() => _selectedPlan = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: selected ? nColor.withOpacity(0.08) : AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected ? nColor : AppColors.dividerColor,
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      p.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: selected ? nColor : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          p.price,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: selected ? nColor : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          p.validity,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
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
                  'Wallet balance',
                  style: AppTextStyles.rowTitle.copyWith(fontSize: 12.5),
                ),
                const SizedBox(height: 1),
                Text(
                  '₦2,450.75 available',
                  style: AppTextStyles.rowSubtitle.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            '₦2,450.75',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryPurple,
            ),
          ),
        ],
      ),
    );
  }
}

class _Network {
  final String name;
  final Color color;
  final Color textColor;

  const _Network({
    required this.name,
    required this.color,
    required this.textColor,
  });
}

class _DataPlan {
  final String label;
  final String price;
  final String validity;

  const _DataPlan({
    required this.label,
    required this.price,
    required this.validity,
  });
}
