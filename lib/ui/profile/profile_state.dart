import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';
import '../../domain/goal/model/complete_goal_model.dart';
import '../../domain/todo/model/graph_data_model.dart';
import '../onboarding/onboarding_state.dart';

class ProfileState extends Equatable {
  final List<bool> opened;

  // status
  final LoadingStatus loadingGoalList;
  final LoadingStatus loadingCharacters;
  final LoadingStatus loadingRegister;
  final LoadingStatus loadingGraph;
  final LoadingStatus loadingProfile;
  final bool isProfileButtonsOpen;
  final int currentGraphIndex;
  final bool isAm;
  final int queryYear;
  final int queryMonth;
  final int currentYear;
  final int currentMonth;
  final int currentTapGoalIndex;

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

  // goal
  final List<CompleteGoalModel> completeGoal;

  // graph
  final List<GraphDataModel> spotsList;

  const ProfileState({
    required this.loadingGoalList,
    required this.loadingCharacters,
    required this.currentTapGoalIndex,
    required this.completeGoal,
    required this.currentYear,
    required this.currentMonth,
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
    required this.queryYear,
    required this.queryMonth,
  });

  ProfileState.init()
      : loadingGraph = LoadingStatus.none,
        loadingRegister = LoadingStatus.none,
        loadingGoalList = LoadingStatus.none,
        loadingCharacters = LoadingStatus.none,
        completeGoal = <CompleteGoalModel>[],
        currentTapGoalIndex = 0,
        currentMonth = 0,
        currentYear = 0,
        queryYear = 0,
        queryMonth = 0,
        isAm = true,
        currentGraphIndex = 0,
        opened = <bool>[],
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
        spotsList = <GraphDataModel>[];

  ProfileState copyWith({
    LoadingStatus? loadingGoalList,
    LoadingStatus? loadingCharacters,
    int? currentTapGoalIndex,
    List<CompleteGoalModel>? completeGoal,
    int? currentYear,
    int? currentMonth,
    int? queryYear,
    int? queryMonth,
    LoadingStatus? loadingRegister,
    bool? isAm,
    LoadingStatus? loadingGraph,
    int? currentGraphIndex,
    List<bool>? opened,
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
    List<GraphDataModel>? spotsList,
  }) =>
      ProfileState(
        loadingCharacters: loadingCharacters ?? this.loadingCharacters,
        loadingGoalList: loadingGoalList ?? this.loadingGoalList,
        currentTapGoalIndex: currentTapGoalIndex ?? this.currentTapGoalIndex,
        completeGoal: completeGoal ?? this.completeGoal,
        currentMonth: currentMonth ?? this.currentMonth,
        currentYear: currentYear ?? this.currentYear,
        queryYear: queryYear ?? this.queryYear,
        queryMonth: queryMonth ?? this.queryMonth,
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
        queryYear,
        queryMonth,
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
