import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Warna utama
  static const Color primary = Color(0xFF4338CA);
  static const Color primaryLight = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color primarySurface = Color(0xFFEEF2FF);

  static const Color accent = Color(0xFFF5C06A);
  static const Color accentLight = Color(0xFFFDF3E0);
  static const Color accentDark = Color(0xFFE5A845);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F7F8);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);

  // Warna mood dan semantik
  static const Color moodHappy = Color(0xFFA3E635);
  static const Color moodGood = Color(0xFF66BB9A);
  static const Color moodNeutral = Color(0xFFF5C06A);
  static const Color moodSad = Color(0xFF94A3B8);
  static const Color moodBad = Color(0xFFE85D5D);
  static const Color moodCalm = Color(0xFFD4C5F9);

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF5E6A3);
  static const Color error = Color(0xFFE85D5D);

  static const Color white = Color(0xFFFFFFFF);

  static BoxDecoration cardDeco({
    Color color = card,
    double radius = 16,
    bool elevated = false,
    double borderOpacity = 1,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: border.withOpacity(borderOpacity)),
      boxShadow: elevated
          ? [
              BoxShadow(
                color: primary.withOpacity(0.045),
                offset: const Offset(0, 6),
                blurRadius: 22,
              ),
            ]
          : null,
    );
  }

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white,
    primaryContainer: primaryLight,
    onPrimaryContainer: white,
    secondary: accent,
    onSecondary: textPrimary,
    secondaryContainer: accentLight,
    onSecondaryContainer: textPrimary,
    tertiary: moodGood,
    onTertiary: white,
    tertiaryContainer: moodCalm,
    onTertiaryContainer: textPrimary,
    error: error,
    onError: white,
    errorContainer: Color(0xFFFFE4E6),
    onErrorContainer: textPrimary,
    surface: surface,
    onSurface: textPrimary,
    surfaceContainerHighest: primarySurface,
    onSurfaceVariant: textSecondary,
    outline: border,
    outlineVariant: Color(0xFFF1F5F9),
    shadow: Color(0x1A4338CA),
    scrim: Color(0x80000000),
    inverseSurface: textPrimary,
    onInverseSurface: white,
    inversePrimary: primaryLight,
  );
}
