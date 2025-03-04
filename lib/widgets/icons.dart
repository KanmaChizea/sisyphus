import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/theme/extension.dart';

class AppIcons {
  AppIcons._();
  static const String _basePath = 'assets/svgs/';

  static const String menu = '${_basePath}menu.svg';
  static const String web = '${_basePath}globe.svg';
  static const String logo = '${_basePath}logo.svg';
  static const String search = '${_basePath}search.svg';

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
