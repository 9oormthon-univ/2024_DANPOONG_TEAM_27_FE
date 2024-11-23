import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/goal/model/goal_model.dart';
import '../../domain/todo/model/todo_model.dart';

class HomeState extends Equatable {
  final LoadingStatus getCurrentGoalLoadingstatus;
  final LoadingStatus getCurrentTodoLoadingstatus;
  final LoadingStatus editCurrentGoalLoadingstatus;
  final LoadingStatus deleteGoalLoadingStatus;
  final LoadingStatus updateTodoLoadingStatus;
  final bool isGoalEditing;
  final bool isGoalButtonOpen;
  final bool isGoalCompleted;
  final bool isGoalRegistered;
  final GoalModel currentGoal;
  final String editingStartDate;
  final String editingEndDate;
  final String editingGoal;
  final List<TodoModel> currentTodoList;

  const HomeState({
    required this.getCurrentGoalLoadingstatus,
    required this.getCurrentTodoLoadingstatus,
    required this.editCurrentGoalLoadingstatus,
    required this.deleteGoalLoadingStatus,
    required this.updateTodoLoadingStatus,
    required this.isGoalEditing,
    required this.isGoalButtonOpen,
    required this.isGoalCompleted,
    required this.isGoalRegistered,
    required this.currentGoal,
    required this.editingStartDate,
    required this.editingEndDate,
    required this.editingGoal,
    required this.currentTodoList,
  });
  HomeState.init()
      : getCurrentGoalLoadingstatus = LoadingStatus.none,
        getCurrentTodoLoadingstatus = LoadingStatus.none,
        editCurrentGoalLoadingstatus = LoadingStatus.none,
        deleteGoalLoadingStatus = LoadingStatus.none,
        updateTodoLoadingStatus = LoadingStatus.none,
        isGoalEditing = false,
        isGoalButtonOpen = false,
        isGoalCompleted = false,
        isGoalRegistered = true,
        currentTodoList = <TodoModel>[],
        editingStartDate = '',
        editingEndDate = '',
        editingGoal = '',
        currentGoal = GoalModel(
          goalId: -999,
          name: '',
          isCompleted: false,
          startDate: DateTime(2024),
          endDate: DateTime(2024),
        );

  HomeState copyWith({
    LoadingStatus? getCurrentGoalLoadingstatus,
    LoadingStatus? getCurrentTodoLoadingstatus,
    LoadingStatus? editCurrentGoalLoadingstatus,
    LoadingStatus? deleteGoalLoadingStatus,
    LoadingStatus? updateTodoLoadingStatus,
    bool? isGoalEditing,
    bool? isGoalButtonOpen,
    bool? isGoalCompleted,
    bool? isGoalRegistered,
    String? editingStartDate,
    String? editingEndDate,
    String? editingGoal,
    GoalModel? currentGoal,
    List<TodoModel>? currentTodoList,
  }) =>
      HomeState(
        getCurrentGoalLoadingstatus:
            getCurrentGoalLoadingstatus ?? this.getCurrentGoalLoadingstatus,
        getCurrentTodoLoadingstatus:
            getCurrentTodoLoadingstatus ?? this.getCurrentTodoLoadingstatus,
        editCurrentGoalLoadingstatus:
            editCurrentGoalLoadingstatus ?? this.editCurrentGoalLoadingstatus,
        deleteGoalLoadingStatus:
            deleteGoalLoadingStatus ?? this.deleteGoalLoadingStatus,
        updateTodoLoadingStatus:
            updateTodoLoadingStatus ?? this.updateTodoLoadingStatus,
        isGoalEditing: isGoalEditing ?? this.isGoalEditing,
        isGoalButtonOpen: isGoalButtonOpen ?? this.isGoalButtonOpen,
        isGoalCompleted: isGoalCompleted ?? this.isGoalCompleted,
        isGoalRegistered: isGoalRegistered ?? this.isGoalRegistered,
        editingStartDate: editingStartDate ?? this.editingStartDate,
        editingEndDate: editingEndDate ?? this.editingEndDate,
        editingGoal: editingGoal ?? this.editingGoal,
        currentGoal: currentGoal ?? this.currentGoal,
        currentTodoList: currentTodoList ?? this.currentTodoList,
      );

  @override
  List<Object> get props => <Object>[
        getCurrentGoalLoadingstatus,
        getCurrentTodoLoadingstatus,
        editCurrentGoalLoadingstatus,
        deleteGoalLoadingStatus,
        updateTodoLoadingStatus,
        isGoalEditing,
        isGoalButtonOpen,
        isGoalCompleted,
        isGoalRegistered,
        editingStartDate,
        editingEndDate,
        editingGoal,
        currentGoal,
        currentTodoList,
      ];

  String get formattedStartDate =>
      '''${currentGoal.startDate.year}.${currentGoal.startDate.month}.${currentGoal.startDate.day}''';
  String get formattedEndDate =>
      '''${currentGoal.endDate.year}.${currentGoal.endDate.month}.${currentGoal.endDate.day}''';
}
