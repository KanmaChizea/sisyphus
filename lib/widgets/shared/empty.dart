import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/shared/typography.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, required this.text});
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          title,
          size: 18,
          weight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        AppText(
          text,
          weight: FontWeight.w500,
          color: Theme.of(context).appColors.grey1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
