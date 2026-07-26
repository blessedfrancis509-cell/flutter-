import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(const ZenCashApp());
}

class ZenCashApp extends StatelessWidget {
  const ZenCashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenCash',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      scrollBehavior: const _WebScrollBehavior(),
      home: const _MobileFrame(child: LoginScreen()),
    );
  }
}

class _MobileFrame extends StatelessWidget {
  final Widget child;
  const _MobileFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 480;
        if (!isWide) return child;
        return Container(
          color: const Color(0xFF1B0742),
          alignment: Alignment.center,
          child: Container(
            width: 430,
            height: constraints.maxHeight,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F3F8),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 40,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class _WebScrollBehavior extends ScrollBehavior {
  const _WebScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
