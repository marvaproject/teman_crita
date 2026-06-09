import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/auth_controls.dart';
import '../../main.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final scale = screenWidth / 768.0;

    // Helper function for responsive text size clamping
    double clampText(double specSize, double min, double max) {
      return (specSize * scale).clamp(min, max);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Soft Vertical Gradient (Full top to bottom)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.white,
                  AppColors.primarySurface,
                ],
              ),
            ),
          ),

          // 2. Bottom Decorative Cloud Layer (cloud_splash.png with no height limit, matches register)
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Image.asset(
              'assets/images/cloud_splash.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // 3. Positioned Star Decorations (White, Lavender, Yellow) around the mascot area
          // Top Left White Star
          Positioned(
            left: 80.0 * scale,
            top: 140.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 28.0 * scale,
              color: Colors.white,
            ),
          ),
          // Top Right White Star
          Positioned(
            right: 86.0 * scale,
            top: 160.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 24.0 * scale,
              color: Colors.white,
            ),
          ),
          // Mid Left Yellow Star
          Positioned(
            left: 110.0 * scale,
            top: 260.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 24.0 * scale,
              color: AppColors.accent,
            ),
          ),
          // Mid Right Lavender Star
          Positioned(
            right: 90.0 * scale,
            top: 280.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 24.0 * scale,
              color: const Color(0xFFD4C5F9),
            ),
          ),
          // Lower Left Lavender Star
          Positioned(
            left: 170.0 * scale,
            top: 360.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 22.0 * scale,
              color: const Color(0xFFD4C5F9),
            ),
          ),
          // Lower Right Yellow Star
          Positioned(
            right: 150.0 * scale,
            top: 350.0 * scale,
            child: Icon(
              MingCute.star_fill,
              size: 20.0 * scale,
              color: AppColors.accent,
            ),
          ),

          // 4. Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 78.0 * scale),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spacer
                  SizedBox(height: 100.0 * scale),

                  // Mascot image (splash_mascot.png, matches register)
                  Image.asset(
                    'assets/images/mascot/splash_mascot.png',
                    width: 430.0 * scale,
                    height: 288.0 * scale,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 12.0 * scale),

                  // Headline
                  Text(
                    'Selamat Datang Kembali!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: clampText(43.0, 20.0, 26.0),
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      height: 1.12,
                      letterSpacing: -0.7 * scale,
                    ),
                  ),
                  SizedBox(height: 22.0 * scale),

                  // Subtitle
                  Text(
                    'Senang melihatmu lagi. Yuk lanjutkan perjalanan\nuntuk mengenali diri dan merawat mentalmu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: clampText(22.0, 11.0, 14.0),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      height: 1.34,
                    ),
                  ),
                  SizedBox(height: 72.0 * scale),

                  // Input Form
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthTextField(
                        label: 'Email',
                        hint: 'Masukkan email kamu',
                        icon: Icons.mail_outline_rounded,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        scale: scale,
                        clampText: clampText,
                      ),
                      SizedBox(height: 34.0 * scale),

                      AuthTextField(
                        label: 'Password',
                        hint: 'Masukkan password kamu',
                        icon: Icons.lock_outline_rounded,
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        scale: scale,
                        clampText: clampText,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 24.0 * scale),
                          child: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 34.0 * scale,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 18.0 * scale),

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Text(
                            'Lupa Password?',
                            style: TextStyle(
                              fontSize: clampText(19.0, 10.0, 12.0),
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 42.0 * scale),

                      AuthPrimaryButton(
                        label: 'Masuk',
                        onPressed: state.login,
                        scale: scale,
                        clampText: clampText,
                      ),
                      SizedBox(height: 56.0 * scale),

                      // Divider Row ("atau masuk dengan")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Divider(
                              height: 1.0,
                              thickness: 1.2,
                              color: AppColors.primarySurface,
                            ),
                          ),
                          SizedBox(width: 28.0 * scale),
                          Text(
                            'atau masuk dengan',
                            style: TextStyle(
                              fontSize: clampText(19.0, 10.0, 12.0),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondary,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(width: 28.0 * scale),
                          const Expanded(
                            child: Divider(
                              height: 1.0,
                              thickness: 1.2,
                              color: AppColors.primarySurface,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 42.0 * scale),

                      AuthOutlineButton(
                        label: 'Masuk dengan Google',
                        onPressed: state.login,
                        scale: scale,
                        clampText: clampText,
                        icon: Icon(
                          Bootstrap.google,
                          size: 30.0 * scale,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 54.0 * scale),

                      // Footer Link ("Belum punya akun? Daftar di sini")
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: clampText(22.0, 11.0, 14.0),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondary,
                              height: 1.0,
                            ),
                            children: [
                              const TextSpan(text: 'Belum punya akun? '),
                              TextSpan(
                                text: 'Daftar di sini',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const RegisterScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 48.0 * scale),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
