import 'package:flutter/widgets.dart';

class VerticalSpacing extends StatelessWidget {
  final double height;
  const VerticalSpacing._internal({super.key, required this.height});

  factory VerticalSpacing.tiny({Key? key}) =>
      VerticalSpacing._internal(key: key, height: 4);

  factory VerticalSpacing.small({Key? key}) =>
      VerticalSpacing._internal(key: key, height: 8);

  factory VerticalSpacing.medium({Key? key}) =>
      VerticalSpacing._internal(key: key, height: 16);

  factory VerticalSpacing.big({Key? key}) =>
      VerticalSpacing._internal(key: key, height: 24);

  factory VerticalSpacing.huge({Key? key}) =>
      VerticalSpacing._internal(key: key, height: 36);

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

class HorizontalSpacing extends StatelessWidget {
  final double width;
  const HorizontalSpacing._internal({super.key, required this.width});

  factory HorizontalSpacing.tiny({Key? key}) =>
      HorizontalSpacing._internal(key: key, width: 4);

  factory HorizontalSpacing.small({Key? key}) =>
      HorizontalSpacing._internal(key: key, width: 8);

  factory HorizontalSpacing.medium({Key? key}) =>
      HorizontalSpacing._internal(key: key, width: 16);

  factory HorizontalSpacing.big({Key? key}) =>
      HorizontalSpacing._internal(key: key, width: 24);

  factory HorizontalSpacing.huge({Key? key}) =>
      HorizontalSpacing._internal(key: key, width: 36);

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}
