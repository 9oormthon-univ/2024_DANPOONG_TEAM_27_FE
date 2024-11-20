import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TogetherAnimal extends StatelessWidget {
  final Map<String, int> animalCounts;
  
  const TogetherAnimal({
    super.key,
    required this.animalCounts,
  });

  @override
  Widget build(BuildContext context) {
    const double itemWidth = 40;
    const double itemSpacing = 4;
    const double containerPadding = 24;
    final double containerWidth = (itemWidth * 6) + (itemSpacing * 5) + (containerPadding * 2);

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(horizontal: containerPadding, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: itemSpacing,
        runSpacing: itemSpacing,
        children: animalCounts.entries.map((entry) {
          return SizedBox(
            width: itemWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: itemWidth,
                  child: SvgPicture.asset(
                    entry.key,
                    fit: BoxFit.contain,
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
          );
        }).toList(),
      ),
    );
  }
}