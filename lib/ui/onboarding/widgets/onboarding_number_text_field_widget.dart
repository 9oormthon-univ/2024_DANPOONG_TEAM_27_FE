import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/new_custom_text_field.dart';

class OnboardingNumberTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const OnboardingNumberTextField({
    required this.hintText,
    this.onChanged,
    super.key,
    this.onSubmitted,
    this.inputFormatters,
    this.maxLength,
    this.textInputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) => NewCustomTextField(
    maxLength: maxLength,
        onSubmitted: onSubmitted,
        hintText: hintText,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        focusNode: focusNode,
        height: 40.0,
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
