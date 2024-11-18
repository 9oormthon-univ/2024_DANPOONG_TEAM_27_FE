import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/app/app_service.dart';
import '../service/app/app_state.dart';

final ChangeNotifierProvider<RedirectNotifier> redirectNotifierProvider =
    ChangeNotifierProvider<RedirectNotifier>(
  (ChangeNotifierProviderRef<RedirectNotifier> ref) =>
      RedirectNotifier(ref: ref),
);

// app router 에게 refresh 하라고 알려주는 notifier입니다.
class RedirectNotifier extends ChangeNotifier {
  final Ref _ref;

  RedirectNotifier({
    required Ref<Object?> ref,
  }) : _ref = ref {
    _ref.listen(appServiceProvider.select((AppState value) => value.isSignedIn),
        (bool? previous, bool next) {
      notifyListeners();
    });
  }
}
