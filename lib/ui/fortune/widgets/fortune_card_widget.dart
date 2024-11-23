import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class FortuneCardWidget extends StatelessWidget {
  final String shortFortune;
  final String fullFortune;
  const FortuneCardWidget({
    required this.shortFortune,
    required this.fullFortune,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: LuckitColors.shadow2.withOpacity(0.15),
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.circular(16),
            color: LuckitColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                shortFortune,
                style: LuckitTypos.suitSB16.copyWith(
                  color: LuckitColors.main,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                fullFortune,
                style: LuckitTypos.suitR12.copyWith(
                  color: LuckitColors.gray80,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ],
          ),
        ),
      );
}
