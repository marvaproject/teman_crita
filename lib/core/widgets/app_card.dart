import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum AppCardVariant {
  section,
  compact,
  inner,
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.section,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.fullWidth = true,
  });

  const AppCard.section({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.fullWidth = true,
  }) : variant = AppCardVariant.section;

  const AppCard.compact({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.fullWidth = true,
  }) : variant = AppCardVariant.compact;

  const AppCard.inner({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.fullWidth = true,
  }) : variant = AppCardVariant.inner;

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final VoidCallback? onTap;
  final bool fullWidth;

  double get _radius {
    switch (variant) {
      case AppCardVariant.section:
      case AppCardVariant.compact:
        return 24.0;
      case AppCardVariant.inner:
        return 16.0;
    }
  }

  EdgeInsetsGeometry get _padding {
    if (padding != null) return padding!;
    switch (variant) {
      case AppCardVariant.section:
        return const EdgeInsets.all(20.0);
      case AppCardVariant.compact:
        return const EdgeInsets.all(16.0);
      case AppCardVariant.inner:
        return const EdgeInsets.all(14.0);
    }
  }

  bool get _elevated => variant != AppCardVariant.inner;

  Color get _color {
    if (color != null) return color!;
    switch (variant) {
      case AppCardVariant.inner:
        return AppColors.surface;
      case AppCardVariant.section:
      case AppCardVariant.compact:
        return AppColors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: fullWidth ? double.infinity : null,
      margin: margin,
      padding: _padding,
      decoration: AppColors.cardDeco(
        color: _color,
        radius: _radius,
        elevated: _elevated,
        borderOpacity: _elevated ? 0.32 : 0,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_radius),
      child: content,
    );
  }
}
