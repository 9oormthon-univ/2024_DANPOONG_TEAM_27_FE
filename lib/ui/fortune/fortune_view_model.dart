import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/fortune/model/fortune_model.dart';
import '../../domain/fortune/use_case/get_fortune_use_case.dart';
import 'fortune_state.dart';

final AutoDisposeStateNotifierProvider<FortuneViewModel, FortuneState>
    fortuneViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<FortuneState> ref) => FortuneViewModel(
    state: const FortuneState.init(),
    getFortuneUseCase: ref.read(getFortuneUseCaseProvider),
  ),
);

class FortuneViewModel extends StateNotifier<FortuneState> {
  final GetFortuneUseCase _getFortuneUseCase;
  FortuneViewModel({
    required FortuneState state,
    required GetFortuneUseCase getFortuneUseCase,
  })  : _getFortuneUseCase = getFortuneUseCase,
        super(state);

  void onSelectFortune({required String title}) {
    state = state.copyWith(selectdTitle: title);
  }

  Future<void> getFortune() async {
    state = state.copyWith(loadingStatus: LoadingStatus.loading);
    final UseCaseResult<FortuneModel> result = await _getFortuneUseCase.call();

    switch (result) {
      case SuccessUseCaseResult<FortuneModel>():
        state = state.copyWith(
          loadingStatus: LoadingStatus.success,
          fortune: result.data,
        );
      case FailureUseCaseResult<FortuneModel>():
        state = state.copyWith(loadingStatus: LoadingStatus.error);
    }
  }
}
