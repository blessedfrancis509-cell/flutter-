import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/presentation/screens/home_screen.dart';

/// Clean login screen — smooth gradient background, simple card.
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
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
          // Smooth gradient background
          Container(
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2D1066),
                  Color(0xFF1E0A3C),
                  Color(0xFF150830),
                ],
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
                      const SizedBox(height: 60),
                      _buildLogo(),
                      const SizedBox(height: 32),
                      _buildLoginCard(),
                      const SizedBox(height: 24),
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
        Container(
          width: 68,
          height: 68,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF8B5CF6),
                Color(0xFF6D28D9),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Text(
            'Z',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'ZenCash',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Your digital banking partner',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
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
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: AppColors.shadowSoft, blurRadius: 16, offset: Offset(0, 6)),
            BoxShadow(color: AppColors.shadowMedium, blurRadius: 32, offset: Offset(0, 12)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
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
                style: AppTextStyles.rowValueMuted.copyWith(fontSize: 11),
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
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.cardSurfaceAlt,
            borderRadius: BorderRadius.circular(10),
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
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.cardSurfaceAlt,
            borderRadius: BorderRadius.circular(10),
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
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryPurpleLight,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryPurpleLight,
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
