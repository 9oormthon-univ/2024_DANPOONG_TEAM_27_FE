import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';

class TogetherAnimal extends StatelessWidget {
  final Map<String, int> animalCounts;

  const TogetherAnimal({
    required this.animalCounts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double itemWidth = 40;
    const double itemSpacing = 4;
    const double containerPadding = 24;
    const double containerWidth =
        (itemWidth * 6) + (itemSpacing * 5) + (containerPadding * 2);

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(
          horizontal: containerPadding, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: LuckitColors.shadow1,
          ),
        ],
      ),
      child: Wrap(
        spacing: itemSpacing,
        runSpacing: itemSpacing,
        children: animalCounts.entries
            .map((MapEntry<String, int> entry) => SizedBox(
                  width: itemWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: itemWidth,
                        child: SvgPicture.asset(
                          entry.key,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${entry.value}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
