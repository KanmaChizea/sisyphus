import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/theme/extension.dart';

class AppIcons {
  AppIcons._();
  static const String _basePath = 'assets/svgs/';

  static const String arrowDown = '${_basePath}arrow-down.svg';
  static const String arrowDownRound = '${_basePath}arrow-down-round.svg';
  static const String arrowUp = '${_basePath}arrow-up.svg';
  static const String check = '${_basePath}check.svg';
  static const String checkActive = '${_basePath}check-active.svg';
  static const String clock = '${_basePath}clock.svg';
  static const String currency = '${_basePath}currency.svg';
  static const String down = '${_basePath}down.svg';
  static const String greenLine = '${_basePath}green-line.svg';
  static const String info = '${_basePath}info-circle.svg';
  static const String logo = '${_basePath}logo.svg';
  static const String menu = '${_basePath}menu.svg';
  static const String redLine = '${_basePath}red-line.svg';
  static const String redGreenLine = '${_basePath}red-green-line.svg';
  static const String search = '${_basePath}search.svg';
  static const String volume = '${_basePath}volume.svg';
  static const String web = '${_basePath}globe.svg';

  /// Returns an SVG icon widget
  static Widget svg(
    String assetName, {
    double size = 24.0,
    Color? color,
    bool adaptable = false,
  }) {
    final context = navigatorKey.currentContext;

    final defaultColor =
        (adaptable && context != null)
            ? Theme.of(context).appColors.text
            : null;
    return SvgPicture.asset(
      assetName,
      width: size,
      height: size,
      colorFilter:
          (color ?? defaultColor) != null
              ? ColorFilter.mode(color ?? defaultColor!, BlendMode.srcIn)
              : null,
    );
  }
}
