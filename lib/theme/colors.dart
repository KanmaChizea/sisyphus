import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color background;
  final Color foreground;
  final Color border;
  final Color green;
  final Color red;
  final Color grey1;
  final Color grey2;
  final Color text;

  const AppColorsTheme._internal({
    required this.background,
    required this.foreground,
    required this.border,
    required this.green,
    required this.red,
    required this.grey1,
    required this.grey2,
    required this.text,
  });

  factory AppColorsTheme.light() {
    return const AppColorsTheme._internal(
      background: Color(0xFFF8F8F9),
      foreground: Color(0xFFFFFFFF),
      text: Color(0xFF1C2127),
      border: Color(0xFFF1F1F1),
      red: Color(0xFFFF554A),
      green: Color(0xFF25C26E),
      grey1: Color(0xFF737A91),
      grey2: Color(0xFFCFD3D8),
    );
  }

  factory AppColorsTheme.dark() {
    return const AppColorsTheme._internal(
      background: Color(0xFF1C2127),
      foreground: Color(0xFF17181B),
      text: Color(0xFFFFFFFF),
      border: Color(0xFF262932),
      red: Color(0xFFFF554A),
      green: Color(0xFF25C26E),
      grey1: Color(0xFFA7B1BC),
      grey2: Color(0xFF555C63),
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
    covariant ThemeExtension<AppColorsTheme>? other,
    double t,
  ) {
    return this;
  }
}
