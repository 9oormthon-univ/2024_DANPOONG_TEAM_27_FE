import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class ChipListWidget extends StatelessWidget {
  final List<String> titles;

  const ChipListWidget({
    super.key,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List<Widget>.generate(
            titles.length,
            (int index) => TextChipWidget(title: titles[index]),
          ),
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
