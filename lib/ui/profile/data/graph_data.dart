import 'package:fl_chart/fl_chart.dart';

import '../../../domain/todo/model/graph_data_model.dart';

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

final List<GraphDataModel> graphData = <GraphDataModel>[
  GraphDataModel(
    missionCount: makeSpots(<double>[5, 9, 7, 15, 15, 18, 22]),
    year: 2024,
    month: 11,
  ),
  GraphDataModel(
    missionCount: makeSpots(<double>[2, 5, 1, 20, 21, 2, 10]),
    year: 2024,
    month: 10,
  ),
  GraphDataModel(
    missionCount: makeSpots(<double>[7, 3, 3, 6, 2, 1, 4]),
    year: 2024,
    month: 9,
  ),
  GraphDataModel(
    missionCount: makeSpots(<double>[6, 8, 9, 6, 12, 2, 5]),
    year: 2024,
    month: 8,
  ),
  GraphDataModel(
    missionCount: makeSpots(<double>[7, 3, 1, 6, 12, 2, 10]),
    year: 2024,
    month: 7,
  ),
];
