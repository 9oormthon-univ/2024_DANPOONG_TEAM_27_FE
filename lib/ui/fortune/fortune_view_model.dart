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

  void onchangeExample({required String example}) {
    state = state.copyWith(example: example);
  }

  void onToggleExample() {
    state = state.copyWith(example: 'example');
  }
}
