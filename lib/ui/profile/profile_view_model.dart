import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'profile_state.dart';

final AutoDisposeStateNotifierProvider<ProfileViewModel, ProfileState>
profileViewModelProvider = StateNotifierProvider.autoDispose(
      (AutoDisposeRef<ProfileState> ref) => ProfileViewModel(
    state: const ProfileState.init(),
  ),
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel({
    required ProfileState state,
  }) : super(state);

  void toggleGoalArchiving() {
    state = state.copyWith(opened: !state.opened);
  }
}
