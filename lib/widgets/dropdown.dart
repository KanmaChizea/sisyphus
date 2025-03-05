import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/icons.dart';
import 'package:sisyphus/widgets/typography.dart';

class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    super.key,
    this.value,
    required this.onChanged,
    required this.list,
    this.width,
    this.menuWidth,
    this.itemBuilder,
    this.child,
    this.valueSize,
    this.valueWeight,
    this.iconSize,
  });
  final T? value;
  final Function(T?) onChanged;
  final List<T> list;
  final double? width;
  final double? menuWidth;

  /// this builds the widget in the input field of the selected item
  final Widget Function(T?)? child;

  /// this builds the items in the dropdown. if this is
  /// not specified but [child] is, the [child] will be used
  final Widget Function(T?)? itemBuilder;

  /// this sets the font size of the selected item
  final double? valueSize;

  /// this sets the icon size of the dropdown arrow
  final double? iconSize;

  /// this sets the font weight of the selected item
  final FontWeight? valueWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: DropdownButton<T>(
          value: value,
          menuWidth: menuWidth ?? width,
          isDense: true,
          icon: AppIcons.svg(
            AppIcons.arrowDown,
            color: Theme.of(context).appColors.grey1,
            size: iconSize ?? 16,
          ),
          elevation: 1,
          dropdownColor: Theme.of(context).appColors.background,
          style: TextStyle(
            fontFamily: 'Satoshi',
            fontSize: 12,
            color: Theme.of(context).appColors.grey1,
          ),
          borderRadius: BorderRadius.circular(8),
          selectedItemBuilder: (context) {
            return list
                .map(
                  (e) => Container(
                    alignment: Alignment.centerLeft,
                    child:
                        child != null
                            ? child!(value)
                            : AppText(
                              value.toString(),
                              size: valueSize,
                              weight: valueWeight,
                            ),
                  ),
                )
                .toList();
          },

          underline: Container(),
          onChanged: onChanged,
          items:
              list.map<DropdownMenuItem<T>>((T value) {
                if (itemBuilder != null) {
                  return DropdownMenuItem(
                    value: value,
                    child: itemBuilder!(value),
                  );
                }
                if (child != null) {
                  return DropdownMenuItem(value: value, child: child!(value));
                }
                return DropdownMenuItem<T>(
                  value: value,
                  child: AppText(value.toString()),
                );
              }).toList(),
        ),
      ),
    );
  }
}
