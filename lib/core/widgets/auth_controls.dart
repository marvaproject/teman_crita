import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.scale,
    required this.clampText,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.helperText,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final double scale;
  final double Function(double specSize, double min, double max) clampText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: clampText(22.0, 12.0, 15.0),
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.0,
          ),
        ),
        SizedBox(height: 16.0 * scale),
        SizedBox(
          height: 86.0 * scale,
          width: double.infinity,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: TextStyle(
              fontSize: clampText(23.0, 12.0, 15.0),
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white.withOpacity(0.84),
              hintText: hint,
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
                  icon,
                  size: 30.0 * scale,
                  color: AppColors.primary,
                ),
              ),
              suffixIcon: suffixIcon,
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
              enabledBorder: _border(scale),
              focusedBorder: _border(
                scale,
                color: AppColors.primary,
                width: 1.8,
              ),
            ),
          ),
        ),
        if (helperText != null) ...[
          SizedBox(height: 18.0 * scale),
          Text(
            helperText!,
            style: TextStyle(
              fontSize: clampText(17.0, 9.0, 11.0),
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              height: 1.2,
            ),
          ),
        ],
      ],
    );
  }
}

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.scale,
    required this.clampText,
  });

  final String label;
  final VoidCallback? onPressed;
  final double scale;
  final double Function(double specSize, double min, double max) clampText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.0 * scale,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
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
            borderRadius: BorderRadius.circular(24.0),
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
              label,
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
    );
  }
}

class AuthOutlineButton extends StatelessWidget {
  const AuthOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.scale,
    required this.clampText,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final double scale;
  final double Function(double specSize, double min, double max) clampText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84.0 * scale,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white.withOpacity(0.86),
          side: const BorderSide(
            color: AppColors.primarySurface,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0 * scale),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 22.0 * scale),
            ],
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: clampText(24.0, 12.0, 15.0),
                  fontWeight: FontWeight.w800,
                  color: icon == null ? AppColors.primary : AppColors.textPrimary,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

OutlineInputBorder _border(
  double scale, {
  Color color = AppColors.primarySurface,
  double width = 1.5,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.0 * scale),
    borderSide: BorderSide(
      color: color,
      width: width,
    ),
  );
}
