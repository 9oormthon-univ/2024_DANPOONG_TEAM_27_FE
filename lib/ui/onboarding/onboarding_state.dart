import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';

class OnboardingState extends Equatable {
  final LoadingStatus getUserNameLoading;
  final LoadingStatus getSuggestionsLoading;

  final String userName;
  final String goalInputFieldText;
  final String goalInputFieldErrorMsg;

  // text field enable, goal 결정, 선택된 목표 인덱스 저장
  final int selectedSuggestion;
  final List<GoalSuggestionModel> suggestions;

  // final String goalNextButtonLabel;
  // final bool isFinishedGoal;

  const OnboardingState({
    required this.getUserNameLoading,
    required this.getSuggestionsLoading,
    required this.userName,
    required this.goalInputFieldText,
    required this.goalInputFieldErrorMsg,
    required this.suggestions,
    // required this.goalNextButtonLabel,
    // required this.isFinishedGoal,
    required this.selectedSuggestion,
  });

  factory OnboardingState.init() => const OnboardingState(
        getUserNameLoading: LoadingStatus.none,
        getSuggestionsLoading: LoadingStatus.none,
        userName: '',
        goalInputFieldText: '',
        goalInputFieldErrorMsg: '',
        suggestions: <GoalSuggestionModel>[],
        selectedSuggestion: -1,
        // goalNextButtonLabel: '다음',
        // isFinishedGoal: false,
      );

  OnboardingState copyWith({
    LoadingStatus? getUserNameLoading,
    LoadingStatus? getSuggestionsLoading,
    String? userName,
    String? goalInputFieldText,
    String? goalTextFieldErrorMsg,
    int? selectedSuggestion,
    List<GoalSuggestionModel>? suggestions,
    // String? goalNextButtonLabel,
    // bool? isFinishedGoal,
  }) =>
      OnboardingState(
        getUserNameLoading: getUserNameLoading ?? this.getUserNameLoading,
        getSuggestionsLoading:
            getSuggestionsLoading ?? this.getSuggestionsLoading,
        userName: userName ?? this.userName,
        goalInputFieldText: goalInputFieldText ?? this.goalInputFieldText,
        selectedSuggestion: selectedSuggestion ?? this.selectedSuggestion,
        goalInputFieldErrorMsg:
            goalTextFieldErrorMsg ?? this.goalInputFieldErrorMsg,
        suggestions: suggestions ?? this.suggestions,
        // goalNextButtonLabel: goalNextButtonLabel ?? this.goalNextButtonLabel,
        // isFinishedGoal: isFinishedGoal ?? this.isFinishedGoal,
      );

  @override
  List<Object?> get props => <Object?>[
        userName,
        goalInputFieldText,
        goalInputFieldErrorMsg,
        selectedSuggestion,
        suggestions,
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
