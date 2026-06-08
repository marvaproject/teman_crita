import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  final bool isPreview;

  const SplashScreen({
    super.key,
    required this.onInitializationComplete,
    this.isPreview = false,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (!widget.isPreview) {
      // Simulate application initialization delay of 3 seconds
      _timer = Timer(const Duration(seconds: 3), () {
        widget.onInitializationComplete();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Background Soft Vertical Gradient
            Container(
              decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.white,
                  Color(0xFFEEF2FF), // Matches the lavender background token
                ],
              ),
            ),
          ),

          // 2. Bottom Cloud Layer Decoration
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.45,
            child: Image.asset(
              'assets/images/cloud_splash.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // 3. Decorative Background Sparkles / Stars (Responsive Proportional Placement)
          // Top Left Sparkle
          Positioned(
            left: size.width * 0.15,
            top: size.height * 0.2,
            child: Icon(
              MingCute.sparkles_fill,
              color: AppColors.primaryLight.withOpacity(0.35),
              size: 20,
            ),
          ),
          // Top Right Sparkle
          Positioned(
            right: size.width * 0.18,
            top: size.height * 0.22,
            child: Icon(
              MingCute.sparkles_fill,
              color: AppColors.primaryLight.withOpacity(0.35),
              size: 20,
            ),
          ),
          // Mid Left Star
          Positioned(
            left: size.width * 0.1,
            top: size.height * 0.42,
            child: const Icon(
              MingCute.star_fill,
              color: AppColors.accent,
              size: 24,
            ),
          ),
          // Mid Right Star
          Positioned(
            right: size.width * 0.12,
            top: size.height * 0.44,
            child: const Icon(
              MingCute.star_fill,
              color: AppColors.accent,
              size: 24,
            ),
          ),
          // Mid-Lower Left Sparkle
          Positioned(
            left: size.width * 0.08,
            top: size.height * 0.58,
            child: Icon(
              MingCute.sparkles_fill,
              color: AppColors.primaryLight.withOpacity(0.4),
              size: 22,
            ),
          ),
          // Mid-Lower Right Star
          Positioned(
            right: size.width * 0.15,
            top: size.height * 0.62,
            child: const Icon(
              MingCute.star_fill,
              color: AppColors.accent,
              size: 20,
            ),
          ),
          // Lower Left Star
          Positioned(
            left: size.width * 0.2,
            top: size.height * 0.78,
            child: const Icon(
              MingCute.star_fill,
              color: AppColors.accent,
              size: 24,
            ),
          ),
          // Lower Right Sparkle
          Positioned(
            right: size.width * 0.15,
            top: size.height * 0.82,
            child: Icon(
              MingCute.sparkles_fill,
              color: AppColors.primaryLight.withOpacity(0.4),
              size: 24,
            ),
          ),

          // 4. Centered Foreground Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Brand Logo (Using SVG Symbol)
                SvgPicture.asset(
                  'assets/images/logo/logo.svg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),

                // Brand Name
                Text(
                  'TemanCrita',
                  textAlign: TextAlign.center,
                  style: AppTypography.textTheme.displayMedium?.copyWith(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 8),

                // Slogan Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      MingCute.sparkles_fill,
                      color: AppColors.accent,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Karena Kamu Gak Sendirian',
                      textAlign: TextAlign.center,
                      style: AppTypography.textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF9F9DFE), // Soft lavender text
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      MingCute.sparkles_fill,
                      color: AppColors.accent,
                      size: 16,
                    ),
                  ],
                ),
                const Spacer(flex: 2),

                // Mascot Cloud Image
                Image.asset(
                  'assets/images/mascot/splash_mascot.png',
                  width: 280.0,
                  height: 190,
                  fit: BoxFit.contain,
                ),
                const Spacer(flex: 2),

                // Circular Progress Indicator Loader
                const SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 16),

                // Loading Text Indicator
                Text(
                  'Menyiapkan ruang amanmu...',
                  textAlign: TextAlign.center,
                  style: AppTypography.textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
