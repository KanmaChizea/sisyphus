import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/shared/icons.dart';
import 'package:sisyphus/widgets/shared/typography.dart';

/// A checkbox item that can display either a [title] or a custom [child] widget,
/// but not both at the same time.
///
/// - If [title] is provided, it will be used as the label for the checkbox.
/// - If [child] is provided, it will be displayed instead.
/// - If both are passed, an assertion error will occur.
class CheckItem extends StatelessWidget {
  /// Creates a [CheckItem] widget.
  ///
  /// [title] and [child] cannot be provided at the same time.
  /// If both are passed, an assertion error will be thrown.
  const CheckItem({
    super.key,
    required this.isActive,
    required this.onChange,
    this.child,
    this.title,
    this.titleSize,
    this.titleColor,
    this.titleFontWeight,
  }) : assert(
         title == null || child == null,
         'Only one of title or child can be provided.',
       );

  /// Indicates whether the checkbox is active or not.
  final bool isActive;

  /// Callback function triggered when the checkbox value changes.
  final Function(bool) onChange;

  /// The title text for the checkbox. Used if [child] is not provided.
  final String? title;

  /// A custom widget displayed in place of [title]. Used if [title] is not provided.
  final Widget? child;

  /// The size of the text for the checkbox title. Default is 12
  final double? titleSize;

  /// The color of the text for the checkbox title. Default is AppColors.grey1
  final Color? titleColor;

  /// The font weight of the text for the checkbox title. Default is FontWeight.w500
  final FontWeight? titleFontWeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).appColors.background,
      child: InkWell(
        onTap: () => onChange(!isActive),
        child: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Container(
                key: ValueKey<bool>(isActive),
                child: AppIcons.svg(
                  isActive ? AppIcons.checkActive : AppIcons.check,
                  size: 16,
                ),
              ),
            ),

            if (child != null)
              child!
            else if (title != null)
              AppText(
                title!,
                size: titleSize ?? 12,
                weight: titleFontWeight ?? FontWeight.w500,
                color: titleColor ?? Theme.of(context).appColors.grey1,
              ),
          ],
        ),
      ),
    );
  }
}
