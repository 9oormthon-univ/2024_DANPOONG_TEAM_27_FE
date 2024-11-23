import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../core/loading_status.dart';
import '../onboarding/onboarding_state.dart';

class ProfileState extends Equatable {
  final bool opened;

  // status
  final LoadingStatus loadingRegister;
  final LoadingStatus loadingGraph;
  final LoadingStatus loadingProfile;
  final bool isProfileButtonsOpen;
  final int currentGraphIndex;
  final bool isAm;

  // user info
  final String name;
  final GenderType gender;
  final BirthType solarOrLunar;
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final bool unknownTime;

  // graph
  final List<List<FlSpot>> spotsList;

  const ProfileState({
    required this.loadingRegister,
    required this.isAm,
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
        loadingRegister = LoadingStatus.none,
        isAm = true,
        currentGraphIndex = 0,
        opened = false,
        loadingProfile = LoadingStatus.none,
        isProfileButtonsOpen = false,
        name = '',
        gender = GenderType.none,
        solarOrLunar = BirthType.none,
        year = '',
        month = '',
        day = '',
        hour = '',
        minute = '',
        unknownTime = false,
        spotsList = <List<FlSpot>>[];

  ProfileState copyWith({
    LoadingStatus? loadingRegister,
    bool? isAm,
    LoadingStatus? loadingGraph,
    int? currentGraphIndex,
    bool? opened,
    LoadingStatus? loadingProfile,
    bool? isProfileButtonsOpen,
    String? name,
    GenderType? gender,
    BirthType? solarOrLunar,
    String? year,
    String? month,
    String? day,
    String? hour,
    String? minute,
    bool? unknownTime,
    List<List<FlSpot>>? spotsList,
  }) =>
      ProfileState(
        loadingRegister: loadingRegister ?? this.loadingRegister,
        isAm: isAm ?? this.isAm,
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
        loadingRegister,
        isAm,
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
