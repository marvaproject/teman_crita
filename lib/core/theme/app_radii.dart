import 'package:flutter/material.dart';

class AppRadii extends ThemeExtension<AppRadii> {
  const AppRadii({
    required this.card,
    required this.button,
    required this.pill,
    required this.bottomSheetTop,
    required this.iconButtonMin,
    required this.iconButtonMax,
  });

  final double card;
  final double button;
  final double pill;
  final double bottomSheetTop;
  final double iconButtonMin;
  final double iconButtonMax;

  static const AppRadii tokens = AppRadii(
    card: 16,
    button: 14,
    pill: 24,
    bottomSheetTop: 24,
    iconButtonMin: 12,
    iconButtonMax: 16,
  );

  BorderRadius get cardBorderRadius => BorderRadius.all(Radius.circular(card));
  BorderRadius get buttonBorderRadius => BorderRadius.all(Radius.circular(button));
  BorderRadius get pillBorderRadius => BorderRadius.all(Radius.circular(pill));
  BorderRadius get bottomSheetBorderRadius => BorderRadius.vertical(top: Radius.circular(bottomSheetTop));
  BorderRadius get iconButtonMinBorderRadius => BorderRadius.all(Radius.circular(iconButtonMin));
  BorderRadius get iconButtonMaxBorderRadius => BorderRadius.all(Radius.circular(iconButtonMax));

  @override
  AppRadii copyWith({
    double? card,
    double? button,
    double? pill,
    double? bottomSheetTop,
    double? iconButtonMin,
    double? iconButtonMax,
  }) {
    return AppRadii(
      card: card ?? this.card,
      button: button ?? this.button,
      pill: pill ?? this.pill,
      bottomSheetTop: bottomSheetTop ?? this.bottomSheetTop,
      iconButtonMin: iconButtonMin ?? this.iconButtonMin,
      iconButtonMax: iconButtonMax ?? this.iconButtonMax,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) return this;
    return AppRadii(
      card: _lerp(card, other.card, t),
      button: _lerp(button, other.button, t),
      pill: _lerp(pill, other.pill, t),
      bottomSheetTop: _lerp(bottomSheetTop, other.bottomSheetTop, t),
      iconButtonMin: _lerp(iconButtonMin, other.iconButtonMin, t),
      iconButtonMax: _lerp(iconButtonMax, other.iconButtonMax, t),
    );
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
