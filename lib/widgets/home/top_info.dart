import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Theme.of(context).appColors.foreground);
  }
}
