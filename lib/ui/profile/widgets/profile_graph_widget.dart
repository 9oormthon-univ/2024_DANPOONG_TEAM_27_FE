import 'package:dotted_line/dotted_line.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../decoration/profile_box_decoration.dart';

class ProfileGraphWidget extends StatelessWidget {
  const ProfileGraphWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 36.0),
        decoration: profileBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 12.0),
              child: Text(
                '목표 달성 그래프',
                style:
                    LuckitTypos.suitSB16.copyWith(color: LuckitColors.gray80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20.0),
              child: Text(
                '달성한 미션',
                style: LuckitTypos.suitR12.copyWith(color: LuckitColors.main),
              ),
            ),
            Stack(
              children: <Widget>[
                const Positioned(
                  left: 28.0,
                  bottom: 10.0,
                  child: DottedLine(
                    direction: Axis.vertical,
                    dashColor: LuckitColors.main,
                    lineLength: 94.0,
                  ),
                ),
                Positioned(
                  left: 28.0,
                  bottom: 10.0,
                  child: DottedLine(
                    dashColor: LuckitColors.main,
                    lineLength: MediaQuery.of(context).size.width - 100,
                  ),
                ),
                Positioned(
                  right: 16.0,
                  bottom: 4.0,
                  child: Text(
                    '일',
                    style: LuckitTypos.suitR12.copyWith(
                      color: LuckitColors.main,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 6.0,
                  ),
                  height: 94.0,
                  child: LineChartWidget(spots: spots),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
                right: 28.0,
                bottom: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 0; i <= 6; i++)
                    Text(
                      i == 0 ? '1' : (i * 5).toString(),
                      style: LuckitTypos.suitR12.copyWith(
                        color: LuckitColors.main,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
}

final List<FlSpot> spots = <FlSpot>[
  const FlSpot(1, 5),
  const FlSpot(5, 9),
  const FlSpot(10, 7),
  const FlSpot(15, 15),
  const FlSpot(20, 18),
  const FlSpot(25, 10),
  const FlSpot(30, 22),
];

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> spots;

  const LineChartWidget({required this.spots, super.key});

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> spotIndexes) => spotIndexes
                    .map(
                      (int index) => const TouchedSpotIndicatorData(
                        FlLine(
                          color: LuckitColors.main,
                          strokeWidth: 1,
                        ),
                        FlDotData(),
                      ),
                    )
                    .toList(),
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (LineBarSpot touchedSpot) => LuckitColors.white,
              tooltipBorder: const BorderSide(color: LuckitColors.gray10),
              tooltipPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            ),
          ),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 1,
          maxX: 31,
          backgroundColor: LuckitColors.transparent,
          minY: 0,
          lineBarsData: <LineChartBarData>[
            LineChartBarData(
              spots: spots,
              dotData: FlDotData(
                getDotPainter: (
                  FlSpot spot,
                  double percent,
                  LineChartBarData barData,
                  int index,
                ) =>
                    FlDotCirclePainter(
                  strokeColor: LuckitColors.main,
                  radius: 4,
                  color: LuckitColors.white,
                  strokeWidth: 0.86,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                color: LuckitColors.main.withOpacity(0.2),
              ),
              color: LuckitColors.main,
              barWidth: 0.86,
            ),
          ],
        ),
      );
}
