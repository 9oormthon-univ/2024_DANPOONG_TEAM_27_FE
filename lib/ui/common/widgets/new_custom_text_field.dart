import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class NewCustomTextField extends StatelessWidget {
  final double? height;
  final double? width;
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
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextEditingController? controller;

  const NewCustomTextField({
    this.textInputType = TextInputType.text,
    this.enabledBorderColor = LuckitColors.gray20,
    this.focusedBorderColor = LuckitColors.main,
    super.key,
    this.height,
    this.width,
    this.enabled = true,
    this.errorText,
    this.hintText,
    this.onChanged,
    this.textStyle = LuckitTypos.suitR16,
    this.hintTextStyle = LuckitTypos.suitR16,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.onSubmitted,
    this.inputFormatters,
    this.textInputAction,
    this.contentPadding,
    this.focusNode,
    this.autofocus = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    );

    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        focusNode: focusNode,
        autofocus: autofocus,
        controller: controller,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        onTapOutside: (PointerDownEvent event) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        textAlign: textAlign,
        onChanged: onChanged,
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding:
          contentPadding ?? const EdgeInsets.symmetric(horizontal: 14.0),
          filled: true,
          fillColor: fillColor ?? LuckitColors.white,
          border: baseBorder,
          enabled: enabled,
          disabledBorder: baseBorder,
          enabledBorder: baseBorder.copyWith(
            borderSide: BorderSide(color: enabledBorderColor),
          ),
          focusedBorder: baseBorder.copyWith(
            borderSide: BorderSide(color: focusedBorderColor),
          ),
          errorBorder: baseBorder.copyWith(
            borderSide: const BorderSide(color: LuckitColors.error),
          ),
          hintText: hintText,
          hintStyle: hintTextStyle.copyWith(height: 0.0),
        ),
        cursorWidth: 1.0,
        cursorColor: LuckitColors.gray80,
        enableInteractiveSelection: false,
        style: textStyle,
      ),
    );
  }
}
