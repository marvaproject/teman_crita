import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../main.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required double scale,
    required double Function(double, double, double) clampText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 82.0 * scale,
          height: 82.0 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF).withOpacity(0.62),
            borderRadius: BorderRadius.circular(22.0 * scale),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 42.0 * scale,
              color: AppColors.primaryLight,
            ),
          ),
        ),
        SizedBox(width: 24.0 * scale),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: clampText(23.0, 14.0, 16.0),
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  height: 1.18,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: clampText(20.0, 12.0, 14.0),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final scale = screenWidth / 768.0;

    // Helper functions for responsive text size clamping
    double clampText(double specSize, double min, double max) {
      return (specSize * scale).clamp(min, max);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
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
                  AppColors.white,
                  Color(0xFFEEF2FF), // Matches the lavender background token
                ],
                stops: [
                  0.0,
                  0.4,
                  1.0,
                ],
              ),
            ),
          ),


          // 2. Positioned Hero Mascot Background (behind the text, full width)
          Positioned(
            height: 673 * scale,
            left: 0.0,
            right: 0.0,
            top: 50 * scale,
            child: Image.asset(
              'assets/images/mascot/onboarding_mascot.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          // 3. Positioned Star Decorations (White, Lavender, Yellow)
          // Top Left White Star
          Positioned(
            left: 74.0 * scale,
            top: 207.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 28.0 * scale,
              color: Colors.white,
            ),
          ),
          // Top Right White Star
          Positioned(
            right: 80.0 * scale,
            top: 229.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 24.0 * scale,
              color: Colors.white,
            ),
          ),
          // Mid Right Lavender Star
          Positioned(
            right: 180.0 * scale,
            top: 367.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 24.0 * scale,
              color: const Color(0xFFD4C5F9),
            ),
          ),
          // Mid Left Yellow Star
          Positioned(
            left: 254.0 * scale,
            top: 380.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 24.0 * scale,
              color: AppColors.accent,
            ),
          ),
          // Lower Right Lavender Star
          Positioned(
            right: 104.0 * scale,
            top: 502.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 22.0 * scale,
              color: const Color(0xFFD4C5F9),
            ),
          ),

          // 4. Scrollable Foreground Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 38.0 * scale),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                  SizedBox(height: 70.0 * scale),

                  // Horizontal Brand Logo (Using SVG + Text)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo/logo.svg',
                        width: 60.0 * scale,
                        height: 60.0 * scale,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 24.0 * scale),
                      Text(
                        'TemanCrita',
                        style: TextStyle(
                          fontSize: clampText(38.0, 14.0, 20.0),
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                          letterSpacing: -1.0 * scale,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Headline Text
                  Text(
                    'Teman untuk\nsetiap cerita dan perasaanmu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: clampText(36.0, 18.0, 26.0),
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      height: 1.25,
                      letterSpacing: -0.5 * scale,
                    ),
                  ),
                  SizedBox(height: 20.0 * scale),

                  // Body Text description
                  Text(
                    'TemanCrita hadir untuk menemani kamu memahami\ndiri, kapan pun kamu membutuhkannya.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: clampText(21.0, 12.0, 15.0),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      height: 1.34,
                    ),
                  ),
                  SizedBox(height: 42.0 * scale),

                  // Three Detailed Feature Rows
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 88.0 * scale),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildFeatureItem(
                          context,
                          icon: MingCute.heart_fill,
                          title: 'Pahami dirimu lebih dalam',
                          description: 'Check-in mood harian dan refleksi diri\nuntuk mengenali perasaanmu.',
                          scale: scale,
                          clampText: clampText,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 28.0 * scale),
                          child: const Divider(
                            height: 1.0,
                            thickness: 1.0,
                            color: Color(0xFFEEF2FF),
                          ),
                        ),
                        _buildFeatureItem(
                          context,
                          icon: MingCute.chat_1_fill,
                          title: 'Dukungan yang selalu ada',
                          description: 'Chat dengan AI Companion yang suportif\nkapan pun kamu butuh teman bicara.',
                          scale: scale,
                          clampText: clampText,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 28.0 * scale),
                          child: const Divider(
                            height: 1.0,
                            thickness: 1.0,
                            color: Color(0xFFEEF2FF),
                          ),
                        ),
                        _buildFeatureItem(
                          context,
                          icon: MingCute.user_3_line,
                          title: 'Terhubung dengan psikolog profesional',
                          description: 'Kami bantu kamu menemukan psikolog yang tepat\ndan terpercaya untukmu.',
                          scale: scale,
                          clampText: clampText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48.0 * scale),

                  // Primary CTA Button: "Mulai Sekarang"
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 72.0 * scale),
                    child: SizedBox(
                      height: 82.0 * scale,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.completeOnboarding,
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26.0 * scale),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [AppColors.primary, AppColors.primaryDark],
                            ),
                            borderRadius: BorderRadius.circular(26.0 * scale),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.26),
                                offset: Offset(0.0, 12.0 * scale),
                                blurRadius: 24.0 * scale,
                                spreadRadius: -8.0 * scale,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Mulai Sekarang',
                              style: TextStyle(
                                fontSize: clampText(28.0, 14.0, 18.0),
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 26.0 * scale),

                  // Secondary Button: "Masuk"
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 72.0 * scale),
                    child: SizedBox(
                      height: 82.0 * scale,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: state.completeOnboarding,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.white.withOpacity(0.82),
                          side: const BorderSide(
                            color: Color(0xFFEEF2FF),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26.0 * scale),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.0 * scale),
                        ),
                        child: Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: clampText(28.0, 14.0, 18.0),
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ),
),
],
      ),
    );
  }
}
