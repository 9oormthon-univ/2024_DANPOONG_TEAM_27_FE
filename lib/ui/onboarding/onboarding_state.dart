import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';

class OnboardingState extends Equatable {
  final LoadingStatus getUserNameLoading;
  final LoadingStatus getSuggestionsLoading;

  final String userName;
  final String goalInputFieldText;
  final String goalInputFieldErrorMsg;
  final String goal;

  // text field enable, goal 결정, 선택된 목표 인덱스 저장
  final int selectedSuggestion;
  final List<GoalSuggestionModel> suggestions;

  const OnboardingState({
    required this.getUserNameLoading,
    required this.getSuggestionsLoading,
    required this.userName,
    required this.goalInputFieldText,
    required this.goalInputFieldErrorMsg,
    required this.suggestions,
    required this.selectedSuggestion,
    required this.goal,
  });

  factory OnboardingState.init() => const OnboardingState(
        getUserNameLoading: LoadingStatus.none,
        getSuggestionsLoading: LoadingStatus.none,
        userName: '',
        goalInputFieldText: '',
        goalInputFieldErrorMsg: '',
        suggestions: <GoalSuggestionModel>[],
        selectedSuggestion: -1,
        goal: '',
      );

  OnboardingState copyWith({
    LoadingStatus? getUserNameLoading,
    LoadingStatus? getSuggestionsLoading,
    String? userName,
    String? goalInputFieldText,
    String? goalInputFieldErrorMsg,
    int? selectedSuggestion,
    List<GoalSuggestionModel>? suggestions,
    String? goal,
  }) =>
      OnboardingState(
        getUserNameLoading: getUserNameLoading ?? this.getUserNameLoading,
        getSuggestionsLoading:
            getSuggestionsLoading ?? this.getSuggestionsLoading,
        userName: userName ?? this.userName,
        goalInputFieldText: goalInputFieldText ?? this.goalInputFieldText,
        selectedSuggestion: selectedSuggestion ?? this.selectedSuggestion,
        goalInputFieldErrorMsg:
            goalInputFieldErrorMsg ?? this.goalInputFieldErrorMsg,
        suggestions: suggestions ?? this.suggestions,
        goal: goal ?? this.goal,
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
