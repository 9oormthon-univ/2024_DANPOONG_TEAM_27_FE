import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/use_case/use_case_result.dart';
import '../../../../core/loading_status.dart';
import '../../domain/example/model/example_model.dart';
import '../../domain/example/use_case/get_example_use_case.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<HomeState> ref) => HomeViewModel(
    state: const HomeState.init(),
    getExampleUseCase: ref.watch(getExampleUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetExampleUseCase _getExampleUseCase;
  HomeViewModel({
    required HomeState state,
    required GetExampleUseCase getExampleUseCase,
  })  : _getExampleUseCase = getExampleUseCase,
        super(state);

  void init() {
    getExample();
  }

  Future<void> getExample() async {
    state = state.copyWith(
      loadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<ExampleModel> result = await _getExampleUseCase(
      title: 'example',
    );

    switch (result) {
      case SuccessUseCaseResult<ExampleModel>():
        state = state.copyWith(
          example: 'result.data',
          loadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<ExampleModel>():
        state = state.copyWith(
          loadingStatus: LoadingStatus.error,
        );
    }
  }

  void onchangeExample({required String example}) {
    state = state.copyWith(example: example);
  }

  void onToggleExample() {
    state = state.copyWith(example: 'example');
  }
}
