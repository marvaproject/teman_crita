import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';
import 'app_radii.dart';

class AppTheme {
  const AppTheme._();

  static ColorScheme get colorScheme => AppColors.colorScheme;
  static TextTheme get textTheme => AppTypography.textTheme;
  static ThemeExtension<dynamic> get spacing => AppSpacing.tokens;
  static ThemeExtension<dynamic> get radii => AppRadii.tokens;

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      colorScheme: AppColors.colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTypography.textTheme,
      extensions: const <ThemeExtension<dynamic>>[
        AppSpacing.tokens,
        AppRadii.tokens,
      ],
    );
  }
}

extension AppThemeContext on BuildContext {
  AppSpacing get spacing =>
      Theme.of(this).extension<AppSpacing>() ?? AppSpacing.tokens;

  AppRadii get radii =>
      Theme.of(this).extension<AppRadii>() ?? AppRadii.tokens;
}
