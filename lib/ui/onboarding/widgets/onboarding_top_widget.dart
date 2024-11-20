import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../views/onboarding_goal_view.dart';

class OnboardingTopWidget extends StatelessWidget {
  final String title;
  final String text;
  final String boldText;
  final bool showShadow;
  final Widget? message;

  const OnboardingTopWidget({
    required this.title,
    required this.text,
    required this.boldText,
    this.showShadow = true,
    this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasMessage = message != null;

    return Container(
      decoration: BoxDecoration(
        color: LuckitColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: showShadow
            ? <BoxShadow>[
                BoxShadow(
                  blurRadius: 10.0,
                  color: shadowColor,
                )
              ]
            : null,
      ),
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 12.0,
        bottom: hasMessage ? 0.0 : 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: LuckitTypos.suitEB32.copyWith(
              color: LuckitColors.main,
            ),
          ),
          const SizedBox(height: 8.0),
          Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: boldText,
                  style: LuckitTypos.suitSB16,
                ),
                TextSpan(
                  text: text,
                  style: LuckitTypos.suitR16,
                ),
              ],
            ),
          ),
          if (hasMessage) message! else const SizedBox.shrink(),
        ],
      ),
    );
  }
}
