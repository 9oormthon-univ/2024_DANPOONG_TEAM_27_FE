import 'package:flutter/material.dart';

import '../../../domain/fortune/model/fortune_model.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import 'circular_graph_widget.dart';

class TimeFortuneGraphListWidget extends StatelessWidget {
  final List<TimeOfDayFortuneScores> timeOfDayFortuneScores;
  const TimeFortuneGraphListWidget({
    required this.timeOfDayFortuneScores,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 16,
            ),
            child: Text(
              '시간대별 운세',
              style: LuckitTypos.suitR14.copyWith(
                color: LuckitColors.gray80,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircularGraphWidget(
                  percentage: timeOfDayFortuneScores.firstWhere(
                    (score) => score.time == 'Morning',
                  ).score,
                  gradiantStart: LuckitColors.gradient2Stop0,
                  gradiantEnd: LuckitColors.gradient2Stop100,
                  timeTitle: '오전',
                ),
                CircularGraphWidget(
                  percentage: timeOfDayFortuneScores.firstWhere(
                    (score) => score.time == 'Afternoon',
                  ).score,
                  gradiantStart: LuckitColors.gradient1Stop42,
                  gradiantEnd: LuckitColors.gradient1Stop100.withOpacity(0.7),
                  stops: const <double>[0.42, 1],
                  timeTitle: '오후',
                ),
                CircularGraphWidget(
                  percentage: timeOfDayFortuneScores.firstWhere(
                    (score) => score.time == 'Night',
                  ).score,
                  gradiantStart: LuckitColors.gradient3Stop0,
                  gradiantEnd: LuckitColors.gradient3Stop100,
                  timeTitle: '밤',
                ),
              ],
            ),
          ),
        ],
      );
}
