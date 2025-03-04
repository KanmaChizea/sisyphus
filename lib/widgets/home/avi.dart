import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
    this.image, {
    super.key,
    this.size,
    this.color,
    this.borderColor,
  });
  final double? size;
  final Color? color;
  final Color? borderColor;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 32,
      width: size ?? 32,
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFF0A0A0),
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.26,
          color: borderColor ?? const Color(0xFFDF9090),
        ),
      ),
      child: Image.asset(image),
    );
  }
}
