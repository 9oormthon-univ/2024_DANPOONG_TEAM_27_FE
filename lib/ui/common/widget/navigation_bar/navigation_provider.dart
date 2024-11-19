import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationState {
  final int currentIndex;
  final int previousIndex;

  NavigationState({
    required this.currentIndex,
    required this.previousIndex,
  });

  NavigationState copyWith({
    int? currentIndex,
    int? previousIndex,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      previousIndex: previousIndex ?? this.previousIndex,
    );
  }
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier()
      : super(NavigationState(currentIndex: 1, previousIndex: 1));

  void setIndex(int index) {
    state = NavigationState(
      currentIndex: index,
      previousIndex: state.currentIndex,
    );
  }

  void resetToHome() {
    state = NavigationState(currentIndex: 0, previousIndex: state.currentIndex);
  }
}

final navigationProvider =
StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});