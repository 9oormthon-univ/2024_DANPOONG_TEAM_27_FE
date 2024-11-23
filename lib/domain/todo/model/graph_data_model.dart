import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphDataModel extends Equatable {
  final List<FlSpot> missionCount;
  final int year;
  final int month;

  const GraphDataModel({
    required this.missionCount,
    required this.year,
    required this.month,
  });

  factory GraphDataModel.fromEntity({
    required List<int> rawDataList,
    required int queryYear,
    required int queryMonth,
  }) =>
      GraphDataModel(
        missionCount: makeSpots(rawDataList),
        year: queryYear,
        month: queryMonth,
      );

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
