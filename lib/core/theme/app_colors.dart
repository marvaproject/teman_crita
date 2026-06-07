import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const primary = Color(0xFF4338CA);
  static const primaryLight = Color(0xFFEEF2FF);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF5F7F8);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFE5E7EB);
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF6B7280);
  static const success = Color(0xFF10B981);

  static BoxDecoration cardDeco({Color color = card}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: border),
    );
  }
}
