import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class BirthTimeTextFieldWidget extends StatelessWidget {
  final bool enabled;
  final String hintText;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextEditingController? controller;

  const BirthTimeTextFieldWidget({
    required this.enabled,
    required this.hintText,
    required this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
    this.maxLength,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextField(
        onTapOutside: (PointerDownEvent event) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        enabled: enabled,
        onChanged: (String value) {
          onChanged(value);
          if (value.length == maxLength) {
            if (textInputAction == TextInputAction.next) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          }
        },
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        maxLength: maxLength,
        style: LuckitTypos.suitR20.copyWith(
          color: enabled ? LuckitColors.gray80 : LuckitColors.gray40,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          fillColor: LuckitColors.white,
          filled: true,
          hintStyle: LuckitTypos.suitR20.copyWith(
            height: 1.5,
            color: LuckitColors.gray20,
          ),
          counterText: '',
        ),
        cursorColor: LuckitColors.gray80,
        cursorWidth: 1.0,
      );
}
