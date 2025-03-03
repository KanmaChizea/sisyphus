import 'package:flutter/material.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  static const _baseFontFamily = 'Inter';
  final TextStyle headline1;
  final TextStyle headline2;

  const AppTextTheme._internal({
    required this.headline1,
    required this.headline2,
  });

  factory AppTextTheme.main() => const AppTextTheme._internal(
        headline1: TextStyle(fontFamily: _baseFontFamily),
        headline2: TextStyle(fontFamily: _baseFontFamily),
      );

  @override
  ThemeExtension<AppTextTheme> copyWith() {
    return AppTextTheme._internal(
      headline1: headline1,
      headline2: headline2,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
      covariant ThemeExtension<AppTextTheme>? other, double t) {
    return this;
  }
}
