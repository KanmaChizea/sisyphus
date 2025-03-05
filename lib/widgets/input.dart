import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/helpers/formatters.dart';
import 'package:sisyphus/widgets/tooltip.dart';
import 'package:sisyphus/widgets/typography.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.obscureText,
    this.suffix,
    this.fieldInfo,
    this.keyboardType,
    this.onChangeText,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String label;
  final bool? obscureText;
  final Widget? suffix;
  final String? fieldInfo;
  final TextInputType? keyboardType;
  final Function(String)? onChangeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: TextField(
              keyboardType: keyboardType,
              controller: controller,
              textAlign: TextAlign.right,
              obscureText: obscureText ?? false,
              onChanged: (val) {
                if (keyboardType == TextInputType.number) {
                  final formattedText = Formatters.parseAndFormatNumber(val);
                  controller?.value = TextEditingValue(
                    text: formattedText,
                    selection: TextSelection.collapsed(
                      offset: formattedText.length,
                    ),
                  );
                }
                if (onChangeText != null) onChangeText!(val);
              },
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                isDense: true,
              ),
              onTapOutside:
                  (_) => FocusScope.of(
                    context,
                  ).unfocus(disposition: UnfocusDisposition.scope),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
