import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tutorial_state.dart';

final AutoDisposeStateNotifierProvider<TutorialViewModel, TutorialState>
    tutorialViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<TutorialState> ref) => TutorialViewModel(
    state: const TutorialState.init(),
  ),
);

class TutorialViewModel extends StateNotifier<TutorialState> {
  TutorialViewModel({
    required TutorialState state,
  }) : super(state);

  void activateButton({required int index}) {
    if (index == 3) {
      state = state.copyWith(activated: true);
    } else {
      state = state.copyWith(activated: false);
    }
  }
}
