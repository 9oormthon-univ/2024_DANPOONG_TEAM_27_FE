import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import 'custom_text_field.dart';

/// 미션 입력 시 사용하는 text field
class MissionTextField extends StatelessWidget {
  final double? fieldWidth;
  final Function(String)? onChanged;
  final String? errorText;

  const MissionTextField({
    super.key,
    this.fieldWidth,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) => CustomTextField(
        fieldHeight: 52.0,
        fieldWidth: fieldWidth,
        onChanged: onChanged,
        hintText: "할 일을 적어주세요",
        enabledBorderColor: LuckitColors.transparent,
        focusedBorderColor: LuckitColors.gray40,
        textInputType: TextInputType.text,
        textStyle: LuckitTypos.suitR16.copyWith(
          color: LuckitColors.black,
        ),
        hintTextStyle: LuckitTypos.suitR12.copyWith(
          color: LuckitColors.gray40,
        ),
      );
}
