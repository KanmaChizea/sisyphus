import 'package:app_template/theme/colors.dart';
import 'package:app_template/theme/textstyles.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtended on ThemeData {
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
  AppTextTheme get appTexts => extension<AppTextTheme>()!;
}
