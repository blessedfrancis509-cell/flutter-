import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/screens/home_screen.dart';

/// Premium login screen with cinematic gradient, animated logo glow,
/// and refined card with gold accent.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;
  bool _agreed = false;
  late final AnimationController _animController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final AnimationController _glowController;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: AppDurations.entrance,
    );
    _fade = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_agreed) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryPurpleDeep,
      body: Stack(
        children: [
          // Cinematic gradient background
          Container(
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.screenGradient,
              ),
            ),
          ),

          // Radial glow behind logo
          Positioned(
            top: size.height * 0.05,
            left: 0,
            right: 0,
            height: size.height * 0.35,
            child: AnimatedBuilder(
              animation: _glow,
              builder: (_, __) => Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 0.7,
                    colors: [
                      AppColors.accentViolet.withOpacity(0.15 * _glow.value),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.xxxl),
                      _buildLogo(),
                      const SizedBox(height: AppSpacing.xl),
                      _buildLoginCard(),
                      const SizedBox(height: AppSpacing.xl),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _glow,
          builder: (_, child) => Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.sendGreen, AppColors.accentViolet, AppColors.primaryPurple],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentViolet.withOpacity(0.3 + 0.15 * _glow.value),
                  blurRadius: 28 + 8 * _glow.value,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: AppColors.sendGreen.withOpacity(0.15 * _glow.value),
                  blurRadius: 40,
                  offset: const Offset(0, 14),
                  spreadRadius: -4,
                ),
              ],
            ),
            child: const Text(
              'Z',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 36,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('ZenCash', style: AppTextStyles.logo.copyWith(fontSize: 28)),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Your digital banking partner',
          style: AppTextStyles.rowSubtitleLight.copyWith(
            color: AppColors.textOnDarkMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: AppColors.accentGold.withOpacity(0.2),
            width: 0.8,
          ),
          boxShadow: const [
            BoxShadow(color: AppColors.shadowSoft, blurRadius: 24, offset: Offset(0, 10)),
            BoxShadow(
              color: AppColors.glowPurple,
              blurRadius: 40,
              offset: Offset(0, 16),
              spreadRadius: -6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back', style: AppTextStyles.screenTitle),
            const SizedBox(height: 2),
            Text('Sign in to your account', style: AppTextStyles.rowSubtitle),
            const SizedBox(height: AppSpacing.xl),
            _buildEmailField(),
            const SizedBox(height: AppSpacing.lg),
            _buildPasswordField(),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _agreed = !_agreed),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _agreed ? AppColors.primaryPurple : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: _agreed ? AppColors.primaryPurple : AppColors.dividerColor,
                        width: 1.5,
                      ),
                    ),
                    child: _agreed
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'I agree to the Terms & Privacy Policy',
                    style: AppTextStyles.rowSubtitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Sign in',
              icon: Iconsax.arrow_right_3,
              loading: _loading,
              onPressed: _agreed ? _login : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            Center(
              child: Text(
                'Demo mode — tap Sign in to continue',
                style: AppTextStyles.rowValueMuted.copyWith(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email address', style: AppTextStyles.rowSubtitle),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.cardSurfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.dividerColor),
          ),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyles.fieldInput,
            decoration: InputDecoration(
              hintText: 'ada.chukwu@zencash.app',
              hintStyle: AppTextStyles.fieldHint,
              prefixIcon: const Icon(Iconsax.sms, size: 18, color: AppColors.textSecondary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: AppTextStyles.rowSubtitle),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.cardSurfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.dividerColor),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: AppTextStyles.fieldInput,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: AppTextStyles.fieldHint,
              prefixIcon: const Icon(Iconsax.lock, size: 18, color: AppColors.textSecondary),
              suffixIcon: GestureDetector(
                onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                child: Icon(
                  _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            'Forgot password?',
            style: AppTextStyles.rowValueMuted.copyWith(
              color: AppColors.primaryPurpleLight,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: AppTextStyles.rowSubtitleLight.copyWith(
                color: AppColors.textOnDarkMuted,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Sign up',
                style: AppTextStyles.rowSubtitleLight.copyWith(
                  color: AppColors.accentGoldLight,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
