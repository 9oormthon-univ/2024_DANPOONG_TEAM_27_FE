import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class ChipListWidget extends StatelessWidget {
  const ChipListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            TextChipWidget(title: '긍정'),
            TextChipWidget(title: '극복'),
            TextChipWidget(title: '자신감'),
            TextChipWidget(title: '귀인'),
          ],
        ),
      );
}

class TextChipWidget extends StatelessWidget {
  const TextChipWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(100),
          color: LuckitColors.gray10,
        ),
        child: Text(
          title,
          style: LuckitTypos.suitR12.copyWith(
            color: LuckitColors.gray80,
          ),
        ),
      );
}