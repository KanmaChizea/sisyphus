import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  static const _white = Color(0xFFF9F9F9);
  static const _black = Color(0xFF0A0A0A);
  static const _red = Color(0xFFFF0000);

  final Color backgroundDefault;
  final Color primary;
  final Color textDefault;

  const AppColorsTheme._internal({
    required this.backgroundDefault,
    required this.primary,
    required this.textDefault,
  });

  factory AppColorsTheme.light() {
    return const AppColorsTheme._internal(
      backgroundDefault: _white,
      primary: _red,
      textDefault: _black,
    );
  }

  factory AppColorsTheme.dark() {
    return const AppColorsTheme._internal(
      backgroundDefault: _white,
      primary: _red,
      textDefault: _black,
    );
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
      covariant ThemeExtension<AppColorsTheme>? other, double t) {
    return this;
  }
}
