import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fortune_state.dart';

final AutoDisposeStateNotifierProvider<FortuneViewModel, FortuneState>
    fortuneViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<FortuneState> ref) => FortuneViewModel(
    state: const FortuneState.init(),
  ),
);

class FortuneViewModel extends StateNotifier<FortuneState> {
  FortuneViewModel({
    required FortuneState state,
  }) : super(state);

  void onSelectFortune({required String title}) {
    state = state.copyWith(selectdTitle: title);
  }
}
