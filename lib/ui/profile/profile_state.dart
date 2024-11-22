import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../core/loading_status.dart';

class ProfileState extends Equatable {
  final bool opened;

  // status
  final LoadingStatus loadingGraph;
  final LoadingStatus loadingProfile;
  final bool isProfileButtonsOpen;
  final int currentGraphIndex;

  // user info
  final String name;
  final String gender;
  final String solarOrLunar;
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final bool unknownTime;

  // graph
  final List<List<FlSpot>> spotsList;

  const ProfileState({
    required this.currentGraphIndex,
    required this.loadingGraph,
    required this.opened,
    required this.loadingProfile,
    required this.isProfileButtonsOpen,
    required this.name,
    required this.gender,
    required this.solarOrLunar,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.unknownTime,
    required this.spotsList,
  });

  ProfileState.init()
      : loadingGraph = LoadingStatus.none,
        currentGraphIndex = 0,
        opened = false,
        loadingProfile = LoadingStatus.none,
        isProfileButtonsOpen = false,
        name = '',
        gender = '',
        solarOrLunar = '',
        year = '',
        month = '',
        day = '',
        hour = '',
        minute = '',
        unknownTime = false,
        spotsList = <List<FlSpot>>[];

  ProfileState copyWith({
    LoadingStatus? loadingGraph,
    int? currentGraphIndex,
    bool? opened,
    LoadingStatus? loadingProfile,
    bool? isProfileButtonsOpen,
    String? name,
    String? gender,
    String? solarOrLunar,
    String? year,
    String? month,
    String? day,
    String? hour,
    String? minute,
    bool? unknownTime,
    List<List<FlSpot>>? spotsList,
  }) =>
      ProfileState(
        loadingGraph: loadingGraph ?? this.loadingGraph,
        currentGraphIndex: currentGraphIndex ?? this.currentGraphIndex,
        opened: opened ?? this.opened,
        loadingProfile: loadingProfile ?? this.loadingProfile,
        isProfileButtonsOpen: isProfileButtonsOpen ?? this.isProfileButtonsOpen,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        solarOrLunar: solarOrLunar ?? this.solarOrLunar,
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        unknownTime: unknownTime ?? this.unknownTime,
        spotsList: spotsList ?? this.spotsList,
      );

  @override
  List<Object> get props => <Object>[
        loadingGraph,
        currentGraphIndex,
        opened,
        loadingProfile,
        isProfileButtonsOpen,
        name,
        gender,
        solarOrLunar,
        year,
        month,
        day,
        hour,
        minute,
        unknownTime,
        spotsList,
      ];
}
