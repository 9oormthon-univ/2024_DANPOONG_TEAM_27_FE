import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class CustomTextField extends StatelessWidget {
  final double? fieldHeight;
  final double? fieldWidth;

  final bool enabled;
  final String? errorText;
  final String? hintText;
  final Function(String)? onChanged;
  final TextAlign textAlign;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final TextInputType textInputType;
  final Color? fillColor;

  const CustomTextField({
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.textInputType,
    super.key,
    this.fieldHeight,
    this.fieldWidth,
    this.enabled = true,
    this.errorText,
    this.hintText,
    this.onChanged,
    this.textStyle = LuckitTypos.suitR16,
    this.hintTextStyle = LuckitTypos.suitR16,
    this.textAlign = TextAlign.start,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    );

    return SizedBox(
      height: fieldHeight,
      width: fieldWidth,
      child: TextField(
        textAlign: textAlign,
        maxLines: 1,
        onChanged: onChanged,
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          filled: true,
          fillColor: fillColor ?? LuckitColors.gray10,
          border: baseBorder,
          enabled: enabled,
          disabledBorder: baseBorder,
          enabledBorder: baseBorder.copyWith(
            borderSide: BorderSide(
              color: enabledBorderColor,
            ),
          ),
          focusedBorder: baseBorder.copyWith(
            borderSide: BorderSide(
              color: focusedBorderColor,
            ),
          ),
          errorBorder: baseBorder.copyWith(
            borderSide: const BorderSide(
              color: LuckitColors.error,
            ),
          ),
          hintText: hintText,
          hintStyle: hintTextStyle.copyWith()
        ),
        cursorWidth: 1.0,
        cursorColor: LuckitColors.gray80,
        enableInteractiveSelection: false,
        style: textStyle,
      ),
    );
  }
}
