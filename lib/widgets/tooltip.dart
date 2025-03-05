import 'package:flutter/material.dart';
import 'package:sisyphus/widgets/icons.dart';

class AppToolTip extends StatelessWidget {
  const AppToolTip({super.key, required this.message, this.icon});
  final String message;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      showDuration: const Duration(seconds: 3),
      preferBelow: false,
      verticalOffset: 8,
      child: icon ?? AppIcons.svg(AppIcons.info, size: 12),
    );
  }
}
