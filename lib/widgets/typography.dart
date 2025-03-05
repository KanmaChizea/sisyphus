import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';

class AppText extends StatelessWidget {
  const AppText(
    String this.data, {
    super.key,
    this.weight,
    this.size,
    this.color,
    this.textAlign,
  });

  final String? data;
  final FontWeight? weight;
  final double? size;
  final Color? color;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: weight ?? FontWeight.w500,
        fontSize: size,
        color: color ?? Theme.of(context).appColors.text,
      ),
    );
  }
}
