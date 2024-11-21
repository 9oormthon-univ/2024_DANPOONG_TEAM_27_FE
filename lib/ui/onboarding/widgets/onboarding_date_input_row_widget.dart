import 'package:flutter/material.dart';

import 'error_text_widget.dart';
import 'onboarding_number_text_field_widget.dart';

class OnboardingDateInputRowWidget extends StatefulWidget {
  final Function(String)? onChangedYear;
  final Function(String)? onChangedMonth;
  final Function(String)? onChangedDay;
  final String? yearErrorText;
  final String? monthErrorText;
  final String? dayErrorText;

  const OnboardingDateInputRowWidget({
    super.key,
    this.onChangedYear,
    this.onChangedMonth,
    this.onChangedDay,
    this.yearErrorText,
    this.monthErrorText,
    this.dayErrorText,
  });

  @override
  State<OnboardingDateInputRowWidget> createState() => _OnboardingDateInputRowWidgetState();
}

class _OnboardingDateInputRowWidgetState extends State<OnboardingDateInputRowWidget> {
  late final FocusNode yearFocusNode;
  late final FocusNode monthFocusNode;
  late final FocusNode dayFocusNode;

  @override
  void initState() {
    super.initState();
    yearFocusNode = FocusNode();
    monthFocusNode = FocusNode();
    dayFocusNode = FocusNode();
  }

  @override
  void dispose() {
    yearFocusNode.dispose();
    monthFocusNode.dispose();
    dayFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          children: <Widget>[
            OnboardingNumberTextField(
              hintText: 'YYYY',
              onChanged: widget.onChangedYear,
              textInputAction: TextInputAction.next,
              focusNode: yearFocusNode,
              onSubmitted: (String p0) => monthFocusNode.requestFocus(),
              maxLength: 4,
            ),
            SizedBox(
              width: double.infinity,
              child: ErrorTextWidget(
                errorTexts: <String?, TextAlign>{
                  widget.yearErrorText: TextAlign.start,
                },
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: OnboardingNumberTextField(
                    hintText: 'MM',
                    onChanged: widget.onChangedMonth,
                    textInputAction: TextInputAction.next,
                    focusNode: monthFocusNode,
                    onSubmitted: (String p0) => dayFocusNode.requestFocus(),
                    maxLength: 2,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OnboardingNumberTextField(
                    hintText: 'DD',
                    onChanged: widget.onChangedDay,
                    textInputAction: TextInputAction.done,
                    focusNode: dayFocusNode,
                    onSubmitted: (String p0) => dayFocusNode.unfocus(),
                    maxLength: 2,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ErrorTextWidget(
                errorTexts: <String?, TextAlign>{
                  widget.monthErrorText: TextAlign.start,
                  widget.dayErrorText: TextAlign.end,
                },
              ),
            )
          ],
        ),
      ),
    ],
  );
}
