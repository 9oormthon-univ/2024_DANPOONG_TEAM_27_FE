import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

/// border color, text color, text size 등등이 다 달라서
/// 이 위젯을 베이스로 사용하려고 합니다
/// mission input field는 본 위젯을 커스텀해서 다시 만들어 뒀습니다
///
/// errorText는 수동으로 구현했습니다
/// 기본 errorText를 쓰려고 보니 height 고정이 어려운 것 같아서요
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
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
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: LuckitColors.error,
                fontSize: 10.0,
              ),
            ),
          ),
      ],
    );
  }
}
