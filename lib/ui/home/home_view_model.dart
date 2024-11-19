import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<HomeState> ref) => HomeViewModel(
    state: const HomeState.init(),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required HomeState state,
  }) : super(state);
}
