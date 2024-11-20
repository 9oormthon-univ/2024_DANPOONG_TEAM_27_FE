import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/custom_text_field.dart';

class OnboardingDateInputField extends StatelessWidget {
  final Function(String)? onChanged;
  final String hintText;
  final String? errorText;

  const OnboardingDateInputField({
    required this.hintText,
    this.onChanged,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CustomTextField(
        hintText: hintText,
        errorText: errorText,
        onChanged: onChanged,
        fieldHeight: 40.0,
        fillColor: LuckitColors.white,
        enabledBorderColor: LuckitColors.gray20,
        focusedBorderColor: LuckitColors.main,
        textInputType: TextInputType.number,
        textStyle: LuckitTypos.suitR20.copyWith(
          color: LuckitColors.gray80,
          height: 0.0,
        ),
        hintTextStyle: LuckitTypos.suitR20.copyWith(
          color: LuckitColors.gray20,
          height: 0.0,
        ),
        textAlign: TextAlign.center,
      );
}
