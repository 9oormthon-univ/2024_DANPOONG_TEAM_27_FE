import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class GoalCompleteState extends Equatable {
  final LoadingStatus loadingStatus;
  final String kingName;
  final DateTime startDate;
  final DateTime endDate;
  final int completedMissions;
  final Map<String, int> animalCounts;
  final String characterAppearAnimation;
  final String characterStopAnimation;

  const GoalCompleteState({
    required this.loadingStatus,
    required this.kingName,
    required this.startDate,
    required this.endDate,
    required this.completedMissions,
    required this.animalCounts,
    required this.characterAppearAnimation,
    required this.characterStopAnimation,
  });

  GoalCompleteState.init()
      : loadingStatus = LoadingStatus.none,
        kingName = '',
        startDate = DateTime.now(),
        endDate = DateTime.now(),
        completedMissions = 0,
        animalCounts = <String, int>{},
        characterAppearAnimation = '',
        characterStopAnimation = '';

  GoalCompleteState copyWith({
    LoadingStatus? loadingStatus,
    String? kingName,
    DateTime? startDate,
    DateTime? endDate,
    int? completedMissions,
    Map<String, int>? animalCounts,
    String? characterAppearAnimation,
    String? characterStopAnimation,
  }) =>
      GoalCompleteState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        kingName: kingName ?? this.kingName,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        completedMissions: completedMissions ?? this.completedMissions,
        animalCounts: animalCounts ?? this.animalCounts,
        characterAppearAnimation:
            characterAppearAnimation ?? this.characterAppearAnimation,
        characterStopAnimation:
            characterStopAnimation ?? this.characterStopAnimation,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        kingName,
        startDate,
        endDate,
        completedMissions,
        animalCounts,
        characterAppearAnimation,
        characterStopAnimation,
      ];
}
