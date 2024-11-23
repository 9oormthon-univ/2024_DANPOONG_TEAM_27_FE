import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphDataModel extends Equatable {
  final List<FlSpot> missionCount;

  const GraphDataModel({
    required this.missionCount,
  });

  factory GraphDataModel.fromEntity({required List<int> rawDataList}) =>
      GraphDataModel(missionCount: makeSpots(rawDataList));

  @override
  List<Object?> get props => <Object?>[
        missionCount,
      ];
}

List<FlSpot> makeSpots(List<int> rawDataList) => List<FlSpot>.generate(
      rawDataList.length,
      (int index) =>
          FlSpot(index < 1 ? 1 : index * 5, rawDataList[index].toDouble()),
    );
