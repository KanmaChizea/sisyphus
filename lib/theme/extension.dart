import 'package:sisyphus/theme/colors.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtended on ThemeData {
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
}
