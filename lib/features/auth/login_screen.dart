import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../core/theme/app_colors.dart';
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
                  Color(0xFFEEF2FF),
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
                      // Email Label
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: clampText(22.0, 12.0, 15.0),
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 16.0 * scale),

                      // Email Field
                      SizedBox(
                        height: 86.0 * scale,
                        width: double.infinity,
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontSize: clampText(23.0, 12.0, 15.0),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white.withOpacity(0.84),
                            hintText: 'Masukkan email kamu',
                            hintStyle: TextStyle(
                              fontSize: clampText(23.0, 12.0, 15.0),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMuted,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                left: 24.0 * scale,
                                right: 18.0 * scale,
                              ),
                              child: Icon(
                                Icons.mail_outline_rounded,
                                size: 30.0 * scale,
                                color: AppColors.primary,
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 78.0 * scale,
                              minHeight: 30.0 * scale,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 26.0 * scale,
                              vertical: 26.0 * scale,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0 * scale),
                              borderSide: const BorderSide(
                                color: Color(0xFFEEF2FF),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0 * scale),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 34.0 * scale),

                      // Password Label
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: clampText(22.0, 12.0, 15.0),
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 16.0 * scale),

                      // Password Field
                      SizedBox(
                        height: 86.0 * scale,
                        width: double.infinity,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          style: TextStyle(
                            fontSize: clampText(23.0, 12.0, 15.0),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white.withOpacity(0.84),
                            hintText: 'Masukkan password kamu',
                            hintStyle: TextStyle(
                              fontSize: clampText(23.0, 12.0, 15.0),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMuted,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                left: 24.0 * scale,
                                right: 18.0 * scale,
                              ),
                              child: Icon(
                                Icons.lock_outline_rounded,
                                size: 30.0 * scale,
                                color: AppColors.primary,
                              ),
                            ),
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
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 78.0 * scale,
                              minHeight: 30.0 * scale,
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 64.0 * scale,
                              minHeight: 34.0 * scale,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 26.0 * scale,
                              vertical: 26.0 * scale,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0 * scale),
                              borderSide: const BorderSide(
                                color: Color(0xFFEEF2FF),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0 * scale),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18.0 * scale),

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Lupa Password diakses')),
                            );
                          },
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

                      // Primary Button ("Masuk")
                      SizedBox(
                        height: 86.0 * scale,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.login,
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0 * scale),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.primary,
                                  AppColors.primaryDark,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(22.0 * scale),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.24),
                                  offset: Offset(0.0, 12.0 * scale),
                                  blurRadius: 24.0 * scale,
                                  spreadRadius: -8.0 * scale,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Masuk',
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
                              color: Color(0xFFEEF2FF),
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
                              color: Color(0xFFEEF2FF),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 42.0 * scale),

                      // Google Button
                      SizedBox(
                        height: 84.0 * scale,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: state.login,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.white.withOpacity(0.86),
                            side: const BorderSide(
                              color: Color(0xFFEEF2FF),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0 * scale),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 24.0 * scale),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Bootstrap.google,
                                size: 30.0 * scale,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 22.0 * scale),
                              Text(
                                'Masuk dengan Google',
                                style: TextStyle(
                                  fontSize: clampText(24.0, 12.0, 15.0),
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
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
