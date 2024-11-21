import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import 'custom_text_field.dart';

/// 미션 입력 시 사용하는 text field
class MissionTextField extends StatelessWidget {
  final double? fieldWidth;
  final Function(String)? onChanged;
  final String? errorText;
  final TextEditingController? controller;
  final String? hintText;

  const MissionTextField({
    super.key,
    this.fieldWidth,
    this.onChanged,
    this.errorText,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) => CustomTextField(
        fieldHeight: 52.0,
        fieldWidth: fieldWidth,
        onChanged: onChanged,
        controller: controller,
        hintText: hintText ?? '예시) 마인드 컨트롤 관련 책 5장 읽기',
        enabledBorderColor: LuckitColors.gray20,
        focusedBorderColor: LuckitColors.gray20,
        textInputType: TextInputType.text,
        textStyle: LuckitTypos.suitR16.copyWith(
          color: LuckitColors.gray80,
        ),
        hintTextStyle: LuckitTypos.suitR12.copyWith(
          color: LuckitColors.gray40,
        ),
    fillColor: LuckitColors.white,
      );
}
