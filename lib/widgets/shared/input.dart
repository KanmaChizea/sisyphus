import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/helpers/formatters.dart';
import 'package:sisyphus/widgets/shared/tooltip.dart';
import 'package:sisyphus/widgets/shared/typography.dart';

class InputField extends StatefulWidget {
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
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool? obscureText;
  final Widget? suffix;
  final String? fieldInfo;
  final TextInputType? keyboardType;
  final Function(String)? onChangeText;
  final FormFieldValidator<String>? validator;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? _errorText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        _errorText = widget.validator?.call(widget.controller.text);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  _errorText != null
                      ? Theme.of(context).appColors.red
                      : Theme.of(context).appColors.border,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            spacing: 4,
            children: [
              AppText(widget.label),
              if (widget.fieldInfo != null)
                AppToolTip(message: widget.fieldInfo!),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  controller: widget.controller,
                  textAlign: TextAlign.right,
                  obscureText: widget.obscureText ?? false,
                  validator: widget.validator,
                  forceErrorText: '',

                  onChanged: (val) {
                    log(val);
                    if (widget.keyboardType == TextInputType.number) {
                      final formattedText = Formatters.parseAndFormatNumber(
                        val,
                      );
                      widget.controller.value = TextEditingValue(
                        text: formattedText,
                        selection: TextSelection.collapsed(
                          offset: formattedText.length,
                        ),
                      );
                    }
                    if (widget.onChangeText != null) widget.onChangeText!(val);
                  },

                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).appColors.text,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    isDense: true,
                    errorStyle: const TextStyle(height: 0.01),
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  onTapOutside:
                      (_) => FocusScope.of(
                        context,
                      ).unfocus(disposition: UnfocusDisposition.scope),
                ),
              ),
              if (widget.suffix != null) widget.suffix!,
            ],
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
            child: AppText(_errorText!, color: Colors.red, size: 12.0),
          ),
      ],
    );
  }
}
