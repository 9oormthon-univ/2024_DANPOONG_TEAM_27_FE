import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/loading_status.dart';
import '../../domain/onboarding/model/suggestion_goal_model.dart';
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
  final List<GoalModel> suggestions;

  // duration
  final String startYear;
  final String startMonth;
  final String startDay;
  final String endYear;
  final String endMonth;
  final String endDay;

  // birth
  final GenderType gender;
  final BirthType birthType;
  final DayPeriod dayPeriod;
  final String birthYear;
  final String birthMonth;
  final String birthDay;
  final String birthHour;
  final String birthMinute;
  final bool dontKnow;
  final bool agree;

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
    required this.gender,
    required this.birthType,
    required this.dayPeriod,
    required this.birthYear,
    required this.birthMonth,
    required this.birthDay,
    required this.birthHour,
    required this.birthMinute,
    required this.dontKnow,
    required this.agree,
  });

  factory OnboardingState.init() => const OnboardingState(
        getUserNameLoading: LoadingStatus.none,
        getSuggestionsLoading: LoadingStatus.none,
        userName: '',
        goalInputFieldText: '',
        goalInputFieldErrorMsg: '',
        suggestions: <GoalModel>[],
        suggestedDuration: '',
        selectedSuggestion: -1,
        goal: '',
        startYear: '',
        startMonth: '',
        startDay: '',
        endYear: '',
        endMonth: '',
        endDay: '',
        gender: GenderType.male,
        birthType: BirthType.solar,
        dayPeriod: DayPeriod.am,
        birthYear: '',
        birthMonth: '',
        birthDay: '',
        birthHour: '',
        birthMinute: '',
        dontKnow: false,
        agree: false,
      );

  OnboardingState copyWith({
    LoadingStatus? getUserNameLoading,
    LoadingStatus? getSuggestionsLoading,
    String? userName,
    String? goalInputFieldText,
    String? goalInputFieldErrorMsg,
    int? selectedSuggestion,
    String? suggestedDuration,
    List<GoalModel>? suggestions,
    String? goal,
    String? startYear,
    String? startMonth,
    String? startDay,
    String? endYear,
    String? endMonth,
    String? endDay,
    GenderType? gender,
    BirthType? birthType,
    DayPeriod? dayPeriod,
    String? birthYear,
    String? birthMonth,
    String? birthDay,
    String? birthHour,
    String? birthMinute,
    bool? dontKnow,
    bool? agree,
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
        gender: gender ?? this.gender,
        birthType: birthType ?? this.birthType,
        dayPeriod: dayPeriod ?? this.dayPeriod,
        birthYear: birthYear ?? this.birthYear,
        birthMonth: birthMonth ?? this.birthMonth,
        birthDay: birthDay ?? this.birthDay,
        birthHour: birthHour ?? this.birthHour,
        birthMinute: birthMinute ?? this.birthMinute,
        dontKnow: dontKnow ?? this.dontKnow,
        agree: agree ?? this.agree,
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



enum GenderType { male, female, none }

enum BirthType { solar, lunar, none }
