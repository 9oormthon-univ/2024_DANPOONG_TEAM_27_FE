import 'package:flutter/material.dart';

import '../../common/widgets/rounded_text_button_widget.dart';
import 'unknown_time_widget.dart';

class AmPmSelectWidget extends StatelessWidget {
  final bool isAm;
  final bool isPm;
  final VoidCallback onPressedAm;
  final VoidCallback onPressedPm;
  final bool unknown;
  final VoidCallback onPressedUnknown;
  final bool leftPadding;

  const AmPmSelectWidget({
    required this.isAm,
    required this.isPm,
    required this.onPressedAm,
    required this.onPressedPm,
    required this.unknown,
    required this.onPressedUnknown,
    this.leftPadding = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      if (leftPadding) const SizedBox(width: 24.0),
      Expanded(
        child: RoundedTextButtonWidget(
          isSelected: isAm,
          label: 'AM',
          onPressed: onPressedAm,
          isActivated: !unknown,
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: RoundedTextButtonWidget(
          isSelected: isPm,
          label: 'PM',
          onPressed: onPressedPm,
          isActivated: !unknown,
        ),
      ),
    ],
  );
}
