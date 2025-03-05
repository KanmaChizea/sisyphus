import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/dropdown.dart';
import 'package:sisyphus/widgets/tooltip.dart';
import 'package:sisyphus/widgets/typography.dart';

class DropdownInput<T> extends StatelessWidget {
  const DropdownInput({
    super.key,
    required this.label,
    this.suffix,
    this.fieldInfo,
    this.value,
    required this.onChanged,
    required this.list,
    this.child,
    this.itemBuilder,
  });

  final String label;
  final Widget? suffix;
  final String? fieldInfo;
  final T? value;
  final Function(T?) onChanged;
  final List<T> list;
  final Widget Function(T?)? child;
  final Widget Function(T?)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).appColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 4,
        children: [
          AppText(label),
          if (fieldInfo != null) AppToolTip(message: fieldInfo!),
          Expanded(
            child: Dropdown(
              value: value,
              onChanged: onChanged,
              list: list,
              child: child,
              itemBuilder: itemBuilder,
              width: (MediaQuery.of(context).size.width * 0.5),
              menuWidth: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
