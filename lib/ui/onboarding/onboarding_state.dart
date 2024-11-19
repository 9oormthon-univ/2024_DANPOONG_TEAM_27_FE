import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';

class OnboardingState extends Equatable {
  // goal
  final LoadingStatus getUserNameLoading;
  final LoadingStatus getSuggestionsLoading;

  final String userName;
  final String goalInputFieldText;
  final String goalInputFieldErrorMsg;
  final String goal;
  final String suggestedDuration;

  // text field enable, goal 결정, 선택된 목표 인덱스 저장
  final int selectedSuggestion;
  final List<GoalSuggestionModel> suggestions;

  // duration
  final String startYear;
  final String startMonth;
  final String startDay;
  final String endYear;
  final String endMonth;
  final String endDay;

  const OnboardingState({
    required this.getUserNameLoading,
    required this.getSuggestionsLoading,
    required this.userName,
    required this.goalInputFieldText,
    required this.goalInputFieldErrorMsg,
    required this.suggestions,
    required this.suggestedDuration,
    required this.selectedSuggestion,
    required this.goal,
    required this.startYear,
    required this.startMonth,
    required this.startDay,
    required this.endYear,
    required this.endMonth,
    required this.endDay,
  });

  factory OnboardingState.init() => const OnboardingState(
        getUserNameLoading: LoadingStatus.none,
        getSuggestionsLoading: LoadingStatus.none,
        userName: '',
        goalInputFieldText: '',
        goalInputFieldErrorMsg: '',
        suggestions: <GoalSuggestionModel>[],
        suggestedDuration: '',
        selectedSuggestion: -1,
        goal: '',
        startYear: '',
        startMonth: '',
        startDay: '',
        endYear: '',
        endMonth: '',
        endDay: '',
      );

  OnboardingState copyWith({
    LoadingStatus? getUserNameLoading,
    LoadingStatus? getSuggestionsLoading,
    String? userName,
    String? goalInputFieldText,
    String? goalInputFieldErrorMsg,
    int? selectedSuggestion,
    String? suggestedDuration,
    List<GoalSuggestionModel>? suggestions,
    String? goal,
    String? startYear,
    String? startMonth,
    String? startDay,
    String? endYear,
    String? endMonth,
    String? endDay,
  }) =>
      OnboardingState(
        getUserNameLoading: getUserNameLoading ?? this.getUserNameLoading,
        getSuggestionsLoading:
            getSuggestionsLoading ?? this.getSuggestionsLoading,
        userName: userName ?? this.userName,
        goalInputFieldText: goalInputFieldText ?? this.goalInputFieldText,
        selectedSuggestion: selectedSuggestion ?? this.selectedSuggestion,
        suggestedDuration: suggestedDuration ?? this.suggestedDuration,
        goalInputFieldErrorMsg:
            goalInputFieldErrorMsg ?? this.goalInputFieldErrorMsg,
        suggestions: suggestions ?? this.suggestions,
        goal: goal ?? this.goal,
        startYear: startYear ?? this.startYear,
        startMonth: startMonth ?? this.startMonth,
        startDay: startDay ?? this.startDay,
        endYear: endYear ?? this.endYear,
        endMonth: endMonth ?? this.endMonth,
        endDay: endDay ?? this.endDay,
      );

  @override
  List<Object?> get props => <Object?>[
        userName,
        goalInputFieldText,
        goalInputFieldErrorMsg,
        selectedSuggestion,
        suggestions,
        goal,
        // goalNextButtonLabel,
        // isFinishedGoal,
      ];
}

class GoalSuggestionModel {
  final String suggestedGoal;
  final String suggestedDuration;

  const GoalSuggestionModel({
    required this.suggestedGoal,
    required this.suggestedDuration,
  });
}
