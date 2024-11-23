import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/fortune/use_case/get_fortune_use_case.dart';
import '../../domain/goal/model/goal_model.dart';
import '../../domain/goal/use_case/create_goal_use_case.dart';
import '../../domain/goal/use_case/delete_goal_use_case.dart';
import '../../domain/goal/use_case/get_goal_list_use_case.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/get_todo_list_use_case.dart';
import '../../domain/todo/use_case/update_todo_use_case.dart';
import '../../domain/user/model/birth_info_model.dart';
import '../../domain/user/model/login_info_model.dart';
import '../../domain/user/use_case/get_birth_info_use_case.dart';
import '../../domain/user/use_case/get_login_info_use_case.dart';
import '../../utils/date_time_format_helper.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<HomeState> ref) => HomeViewModel(
    state: HomeState.init(),
    getGoalListUseCase: ref.read(getGoalListUseCaseProvider),
    getTodoListUseCase: ref.read(getTodoListUseCaseProvider),
    createGoalUseCase: ref.read(createGoalUseCaseProvider),
    deleteGoalUseCase: ref.read(deleteGoalUseCaseProvider),
    updateTodoUseCase: ref.read(updateTodoUseCaseProvider),
    getBirthInfoUseCase: ref.read(getBirthInfoUseCaseProvider),
    getLoginInfoUseCase: ref.read(getLoginInfoUseCaseProvider),
    getFortuneUseCase: ref.read(getFortuneUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetGoalListUseCase _getGoalListUseCase;
  final GetTodoListUseCase _getTodoListUseCase;
  final CreateGoalUseCase _createGoalUseCase;
  final DeleteGoalUseCase _deleteGoalUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final GetBirthInfoUseCase _getBirthInfoUseCase;
  final GetLoginInfoUseCase _getLoginInfoUseCase;
  final GetFortuneUseCase _getFortuneUseCase;

  HomeViewModel({
    required HomeState state,
    required GetGoalListUseCase getGoalListUseCase,
    required GetTodoListUseCase getTodoListUseCase,
    required CreateGoalUseCase createGoalUseCase,
    required DeleteGoalUseCase deleteGoalUseCase,
    required UpdateTodoUseCase updateTodoUseCase,
    required GetBirthInfoUseCase getBirthInfoUseCase,
    required GetLoginInfoUseCase getLoginInfoUseCase,
    required GetFortuneUseCase getFortuneUseCase,
  })  : _getGoalListUseCase = getGoalListUseCase,
        _getTodoListUseCase = getTodoListUseCase,
        _createGoalUseCase = createGoalUseCase,
        _deleteGoalUseCase = deleteGoalUseCase,
        _updateTodoUseCase = updateTodoUseCase,
        _getBirthInfoUseCase = getBirthInfoUseCase,
        _getLoginInfoUseCase = getLoginInfoUseCase,
        _getFortuneUseCase = getFortuneUseCase,
        super(state);

  void init() {
    getCurrentGoal().then((_) {
      getCurrentTodoList();
    });
  }
  Future<void> updateTodo(int todoId, String todo) async{
    state = state.copyWith(updateTodoLoadingStatus: LoadingStatus.loading);
    final UseCaseResult<void> result = await _updateTodoUseCase(
      name: todo,
      todoId: todoId
    );
    switch (result){
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          currentTodoList: state.currentTodoList.map((todoModel) {
            if (todoModel.todoId == todoId) {
              return todoModel.copyWith(name: todo);
            }
            return todoModel;
          }).toList(),
          updateTodoLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<void>():
        state = state.copyWith(
          updateTodoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getCurrentGoal() async {
    state = state.copyWith(getCurrentGoalLoadingstatus: LoadingStatus.loading);
    final UseCaseResult<List<GoalModel>> result = await _getGoalListUseCase();

    switch (result) {
      case SuccessUseCaseResult<List<GoalModel>>():
        if (result.data.isNotEmpty) {
          state = state.copyWith(
            isGoalRegistered: true,
            currentGoal: result.data.first,
            editingStartDate: DateTimeFormatter.getInputDateTimeString(
                result.data.first.startDate),
            editingEndDate: DateTimeFormatter.getInputDateTimeString(
                result.data.first.endDate),
            editingGoal: result.data.first.name,
            getCurrentGoalLoadingstatus: LoadingStatus.success,
          );
        } else {
          state = state.copyWith(
            isGoalRegistered: false,
            getCurrentGoalLoadingstatus: LoadingStatus.success,
          );
        }

      case FailureUseCaseResult<List<GoalModel>>():
        state =
            state.copyWith(getCurrentGoalLoadingstatus: LoadingStatus.error);
    }
  }

  Future<void> editCurrentGoal({
    required String startDateString,
    required String endDateString,
    required String editingGoal,
  }) async {
    state = state.copyWith(getCurrentGoalLoadingstatus: LoadingStatus.loading);
    final String startYear = startDateString.substring(0, 4);
    final String startMonth = startDateString.substring(4, 6);
    final String startDay = startDateString.substring(6, 8);
    final String endYear = endDateString.substring(0, 4);
    final String endMonth = endDateString.substring(4, 6);
    final String endDay = endDateString.substring(6, 8);
    final UseCaseResult<void> result = await _createGoalUseCase(
      endDate: DateTime(
        int.parse(endYear),
        int.parse(endMonth),
        int.parse(endDay),
      ),
      startDate: DateTime(
        int.parse(startYear),
        int.parse(startMonth),
        int.parse(startDay),
      ),
      name: editingGoal,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          currentGoal: state.currentGoal.copyWith(
            name: editingGoal,
            startDate: DateTime(
              int.parse(startYear),
              int.parse(startMonth),
              int.parse(startDay),
            ),
            endDate: DateTime(
              int.parse(endYear),
              int.parse(endMonth),
              int.parse(endDay),
            ),
          ),
          editCurrentGoalLoadingstatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<void>():
        state =
            state.copyWith(editCurrentGoalLoadingstatus: LoadingStatus.error);
    }
  }

  Future<void> getCurrentTodoList() async {
    state = state.copyWith(getCurrentTodoLoadingstatus: LoadingStatus.loading);
    final UseCaseResult<List<TodoModel>> result = await _getTodoListUseCase(
      goalId: state.currentGoal.goalId,
    );

    switch (result) {
      case SuccessUseCaseResult<List<TodoModel>>():
        state = state.copyWith(
          getCurrentTodoLoadingstatus: LoadingStatus.success,
          currentTodoList: result.data,
        );

      case FailureUseCaseResult<List<TodoModel>>():
        state =
            state.copyWith(getCurrentTodoLoadingstatus: LoadingStatus.error);
    }
  }

  Future<void> deleteGoal() async {
    state = state.copyWith(deleteGoalLoadingStatus: LoadingStatus.loading);
    final UseCaseResult<void> result = await _deleteGoalUseCase(
      goalId: state.currentGoal.goalId,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          deleteGoalLoadingStatus: LoadingStatus.success,
          isGoalRegistered: false,
        );

      case FailureUseCaseResult<void>():
        state = state.copyWith(
          deleteGoalLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void toggleGoalButtons({required bool isCurrentOpen}) {
    state = state.copyWith(isGoalButtonOpen: !isCurrentOpen);
  }

  void toggleGoalEdit({required bool isCurrentEditing}) {
    state = state.copyWith(isGoalEditing: !isCurrentEditing);
  }
}
