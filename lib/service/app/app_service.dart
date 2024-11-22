import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../data/auth/entity/auth_token_entity.dart';
// import '../storage/storage_key.dart';
// import '../storage/storage_service.dart';
// import '../../data/auth/entity/auth_token_entity.dart';
// import '../storage/storage_key.dart';
// import '../storage/storage_service.dart';
import '../../domain/auth/model/auth_token_model.dart';
import '../storage/storage_key.dart';
import '../storage/storage_service.dart';
import 'app_state.dart';

final StateNotifierProvider<AppService, AppState> appServiceProvider =
    StateNotifierProvider<AppService, AppState>(
  (Ref ref) => AppService(
    storageService: ref.watch(storageServiceProvider),
    state: const AppState.init(),
  ),
);

class AppService extends StateNotifier<AppState> {
  AppService({
    required StorageService storageService,
    required AppState state,
  })  : _storageService = storageService,
        super(state) {
    init();
  }

  // 로그인 관련 기본 설정들
  final StorageService _storageService;

  Future<void> init() async {
    final String? accessToken =
        await _storageService.getString(key: StorageKey.accessToken);
    final String? refreshToken =
        await _storageService.getString(key: StorageKey.refreshToken);

    if (accessToken != null && refreshToken != null) {
      state = state.copyWith(isSignedIn: true);
    }
  }

  Future<void> signIn({required AuthTokenModel authTokens}) async {
    await _storageService.setString(
      key: StorageKey.accessToken,
      value: authTokens.accessToken,
    );
    await _storageService.setString(
      key: StorageKey.refreshToken,
      value: authTokens.refreshToken,
    );

    state = state.copyWith(isSignedIn: true);
  }

  Future<void> signOut() async {
    state = state.copyWith(isSignedIn: false);
    await _storageService.clearAll();
  }
}
