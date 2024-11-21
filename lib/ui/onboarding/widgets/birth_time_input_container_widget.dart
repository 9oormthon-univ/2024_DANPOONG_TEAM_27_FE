import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import 'birth_time_text_field_widget.dart';

class BirthTimeInputContainerWidget extends StatefulWidget {
  final bool enabled;
  final Function(String) onChangedHour;
  final Function(String) onChangedMinute;

  const BirthTimeInputContainerWidget({
    required this.enabled,
    required this.onChangedHour,
    required this.onChangedMinute,
    super.key,
  });

  @override
  State<BirthTimeInputContainerWidget> createState() =>
      _BirthTimeInputContainerWidgetState();
}

class _BirthTimeInputContainerWidgetState
    extends State<BirthTimeInputContainerWidget> {
  late final FocusNode hourFocusNode;
  late final FocusNode minuteFocusNode;

  @override
  void initState() {
    super.initState();
    hourFocusNode = FocusNode();
    minuteFocusNode = FocusNode();
  }

  @override
  void dispose() {
    hourFocusNode.dispose();
    minuteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            child: BirthTimeTextFieldWidget(
              enabled: widget.enabled,
              hintText: 'HH',
              onChanged: widget.onChangedHour,
              focusNode: hourFocusNode,
              textInputAction: TextInputAction.next,
              onSubmitted: (String _) => minuteFocusNode.requestFocus(),
              maxLength: 2,
            ),
          ),
          Text(
            ':',
            style: LuckitTypos.suitR20.copyWith(
              color: LuckitColors.gray80,
            ),
          ),
          Expanded(
            child: BirthTimeTextFieldWidget(
              enabled: widget.enabled,
              hintText: 'MM',
              onChanged: widget.onChangedMinute,
              focusNode: minuteFocusNode,
              textInputAction: TextInputAction.done,
              onSubmitted: (String _) => minuteFocusNode.unfocus(),
              maxLength: 2,
            ),
          ),
        ],
      );
}
