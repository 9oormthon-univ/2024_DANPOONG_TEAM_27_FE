import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import 'birth_time_input_container_widget.dart';
import 'error_text_widget.dart';

class BirthInputWidget extends StatelessWidget {
  final bool enabled;
  final Function(String) onChangedHour;
  final Function(String) onChangedMinute;
  final String? hourErrMsg;
  final String? minuteErrMsg;
  final bool padding;
  final TextEditingController? hourController;
  final TextEditingController? minuteController;

  const BirthInputWidget({
    required this.enabled,
    required this.onChangedHour,
    required this.onChangedMinute,
    super.key,
    this.hourErrMsg,
    this.minuteErrMsg,
    this.padding = true,
    this.hourController,
    this.minuteController,
  });

  @override
  Widget build(BuildContext context) => Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 40.0,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: LuckitColors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: !enabled ? LuckitColors.gray10 : LuckitColors.gray20,
            ),
          ),
          child: BirthTimeInputContainerWidget(
            hourController: hourController,
            minuteController: minuteController,
            enabled: enabled,
            onChangedHour: onChangedHour,
            onChangedMinute: onChangedMinute,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ErrorTextWidget(
            errorTexts: <String?, TextAlign>{
              hourErrMsg: TextAlign.start,
              minuteErrMsg: TextAlign.end,
            },
          ),
        ),
      ],
    );
}
