import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class GoalGlass extends StatelessWidget {
  const GoalGlass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 15,
                color: const Color(0xFF2F56A5).withOpacity(0.15),

              )
            ],
            borderRadius: BorderRadius.circular(8),
            color: LuckitColors.white.withOpacity(0.1),
            border: Border.all(
              color: LuckitColors.white.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24 ,14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '수정님의 목표',
                      style:
                          LuckitTypos.suitR14.copyWith(color: LuckitColors.white),
                    ),
                    Text(
                      '2024.11.15 ~ 2024.12.15',
                      style:
                          LuckitTypos.suitR14.copyWith(color: LuckitColors.white),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                Text(
                  '자연스럽게 숨쉬기의 농장',
                  style: LuckitTypos.suitSB20.copyWith(color: LuckitColors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
