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

const int _defaultHomeIndex = 1;

/// The maximum allowed navigation index
const int _maxNavigationIndex = 2;

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier()
      : super(NavigationState(
          currentIndex: _defaultHomeIndex,
          previousIndex: _defaultHomeIndex,
        ));

  void setIndex(int index) {
    if (index < 0 || index > _maxNavigationIndex) {
      throw ArgumentError(
          'Navigation index must be between 0 and $_maxNavigationIndex');
    }
    state = NavigationState(
      currentIndex: index,
      previousIndex: state.currentIndex,
    );
  }

  void resetToHome() {
    state = NavigationState(
      currentIndex: _defaultHomeIndex,
      previousIndex: state.currentIndex,
    );
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});
