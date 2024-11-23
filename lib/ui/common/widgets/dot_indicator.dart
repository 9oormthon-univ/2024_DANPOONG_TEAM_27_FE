import 'package:flutter/material.dart';
import '../../../theme/luckit_colors.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;
  final String tag;
  
  const DotIndicator({
    super.key,
    required this.currentIndex,
    required this.totalDots,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalDots, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == currentIndex 
                    ? LuckitColors.main
                    : LuckitColors.gray20,
              ),
            );
          }),
        ),
      ),
    );
  }
} 