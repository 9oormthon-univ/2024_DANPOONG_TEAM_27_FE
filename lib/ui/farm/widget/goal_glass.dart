import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class GoalGlass extends StatelessWidget {
  const GoalGlass({
    required this.userName,
    required this.startDate,
    required this.endDate,
    required this.goalTitle,
    super.key,
  });

  final String userName;
  final DateTime startDate;
  final DateTime endDate;
  final String goalTitle;

  @override
  Widget build(BuildContext context) => ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: DecoratedBox(
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
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 14),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '$userName님의 목표',
                        style: LuckitTypos.suitR14
                            .copyWith(color: LuckitColors.white),
                      ),
                      const SizedBox(
                        width: 54,
                      ),
                      Text(
                        '${DateFormat('yyyy.MM.dd').format(startDate)} ~ ${DateFormat('yyyy.MM.dd').format(endDate)}',
                        style: LuckitTypos.suitR14
                            .copyWith(color: LuckitColors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    goalTitle,
                    style: LuckitTypos.suitSB20
                        .copyWith(color: LuckitColors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
