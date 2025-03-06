import 'package:flutter/material.dart';
import 'package:sisyphus/widgets/shared/typography.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? foregroundColor;
  final double height;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.gradient,
    this.foregroundColor,
    this.height = 32.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: gradient == null ? backgroundColor ?? Colors.blue : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: AppText(
          text,
          color: foregroundColor ?? Colors.white,
          weight: FontWeight.w700,
          size: 16,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
