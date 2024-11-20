import 'package:flutter/material.dart';

import '../../common/widgets/rounded_grey_text_widget.dart';

class SuggestedDurationWidget extends StatelessWidget {
  final bool isChecked;
  final String duration;

  const SuggestedDurationWidget({
    required this.isChecked,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) => RoundedGreyTextWidget(
        label: '추천 기간 $duration',
        activated: isChecked,
      );
}
