import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';

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
