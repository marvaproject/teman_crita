import 'package:flutter/material.dart';

class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.pagePadding,
    required this.pagePaddingCompact,
    required this.cardPaddingHorizontal,
    required this.cardPaddingVertical,
    required this.cardPadding,
    required this.gridGap,
    required this.iconButtonContainer,
    required this.iconInline,
    required this.iconDefault,
    required this.iconSection,
    required this.iconLarge,
    required this.iconButton,
  });

  final double pagePadding;
  final double pagePaddingCompact;
  final double cardPaddingHorizontal;
  final double cardPaddingVertical;
  final EdgeInsets cardPadding;
  final double gridGap;
  final double iconButtonContainer;
  final double iconInline;
  final double iconDefault;
  final double iconSection;
  final double iconLarge;
  final double iconButton;

  static const AppSpacing tokens = AppSpacing(
    pagePadding: 24,
    pagePaddingCompact: 16,
    cardPaddingHorizontal: 14,
    cardPaddingVertical: 20,
    cardPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
    gridGap: 16,
    iconButtonContainer: 40,
    iconInline: 14,
    iconDefault: 18,
    iconSection: 20,
    iconLarge: 24,
    iconButton: 40,
  );

  @override
  AppSpacing copyWith({
    double? pagePadding,
    double? pagePaddingCompact,
    double? cardPaddingHorizontal,
    double? cardPaddingVertical,
    EdgeInsets? cardPadding,
    double? gridGap,
    double? iconButtonContainer,
    double? iconInline,
    double? iconDefault,
    double? iconSection,
    double? iconLarge,
    double? iconButton,
  }) {
    return AppSpacing(
      pagePadding: pagePadding ?? this.pagePadding,
      pagePaddingCompact: pagePaddingCompact ?? this.pagePaddingCompact,
      cardPaddingHorizontal: cardPaddingHorizontal ?? this.cardPaddingHorizontal,
      cardPaddingVertical: cardPaddingVertical ?? this.cardPaddingVertical,
      cardPadding: cardPadding ?? this.cardPadding,
      gridGap: gridGap ?? this.gridGap,
      iconButtonContainer: iconButtonContainer ?? this.iconButtonContainer,
      iconInline: iconInline ?? this.iconInline,
      iconDefault: iconDefault ?? this.iconDefault,
      iconSection: iconSection ?? this.iconSection,
      iconLarge: iconLarge ?? this.iconLarge,
      iconButton: iconButton ?? this.iconButton,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      pagePadding: _lerp(pagePadding, other.pagePadding, t),
      pagePaddingCompact: _lerp(pagePaddingCompact, other.pagePaddingCompact, t),
      cardPaddingHorizontal: _lerp(cardPaddingHorizontal, other.cardPaddingHorizontal, t),
      cardPaddingVertical: _lerp(cardPaddingVertical, other.cardPaddingVertical, t),
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
      gridGap: _lerp(gridGap, other.gridGap, t),
      iconButtonContainer: _lerp(iconButtonContainer, other.iconButtonContainer, t),
      iconInline: _lerp(iconInline, other.iconInline, t),
      iconDefault: _lerp(iconDefault, other.iconDefault, t),
      iconSection: _lerp(iconSection, other.iconSection, t),
      iconLarge: _lerp(iconLarge, other.iconLarge, t),
      iconButton: _lerp(iconButton, other.iconButton, t),
    );
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
