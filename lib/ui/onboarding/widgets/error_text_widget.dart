import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class ErrorTextWidget extends StatelessWidget {
  final Map<String?, TextAlign> errorTexts;

  const ErrorTextWidget({
    required this.errorTexts,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 20.0,
        child: _showErrorText(),
      );

  Widget _showErrorText() {
    final TextStyle errorTextStyle = LuckitTypos.suitR10.copyWith(
      color: LuckitColors.error,
    );

    for (final MapEntry<String?, TextAlign> entry in errorTexts.entries) {
      if (entry.key != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            entry.key!,
            style: errorTextStyle,
            textAlign: entry.value,
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }
}
