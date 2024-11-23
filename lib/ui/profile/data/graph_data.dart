import 'package:fl_chart/fl_chart.dart';

List<FlSpot> makeSpots(List<double> missions) => List<FlSpot>.generate(
    missions.length,
    (int index) => FlSpot(index < 1 ? 1 : index * 5, missions[index]));

final List<FlSpot> spots = <FlSpot>[
  const FlSpot(1, 5),
  const FlSpot(5, 9),
  const FlSpot(10, 7),
  const FlSpot(15, 15),
  const FlSpot(20, 18),
  const FlSpot(25, 10),
  const FlSpot(30, 22),
];

final List<List<FlSpot>> graphData = <List<FlSpot>>[
  makeSpots(<double>[5, 9, 7, 15, 15, 18, 22]),
  makeSpots(<double>[2, 5, 1, 20, 21, 2, 10]),
];
