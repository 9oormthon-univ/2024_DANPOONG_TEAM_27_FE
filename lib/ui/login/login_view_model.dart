import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/auth/model/auth_token_model.dart';
import '../../domain/auth/use_case/get_auth_use_case.dart';
import 'login_state.dart';

final AutoDisposeStateNotifierProvider<LoginViewModel, LoginState>
    loginViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<LoginState> ref) => LoginViewModel(
    state: const LoginState.init(),
    getAuthUseCase: ref.read(getAuthUseCaseProvider),
  ),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final GetAuthUseCase _getAuthUseCase;

  LoginViewModel({
    required LoginState state,
    required GetAuthUseCase getAuthUseCase,
  })  : _getAuthUseCase = getAuthUseCase,
        super(state);

  Future<void> signInWithKakao() async {
    try {
      state = state.copyWith(loadingStatus: LoadingStatus.loading);

      String? authCode;

      try {
        // 카카오톡 설치 여부 확인
        if (await isKakaoTalkInstalled()) {
          try {
            // 카카오톡으로 로그인
            authCode = await AuthCodeClient.instance
                .authorizeWithTalk(redirectUri: KakaoSdk.redirectUri);
          } catch (error) {
            print('카카오톡 로그인 실패: $error');
            // 카카오톡 로그인 실패 시 카카오계정으로 로그인 시도
            authCode = await AuthCodeClient.instance
                .authorize(redirectUri: KakaoSdk.redirectUri);
            print('카카오계정 로그인 인가코드: $authCode');
          }
        } else {
          // 카카오톡 미설치시 카카오계정으로 로그인
          authCode = await AuthCodeClient.instance
              .authorize(redirectUri: KakaoSdk.redirectUri);
        }

        // 인가코드를 받았다면 서버에 전송
        final UseCaseResult<AuthTokenModel> result =
            await _getAuthUseCase.call(code: authCode);

        switch (result) {
          case SuccessUseCaseResult():
            state = state.copyWith(
              loadingStatus: LoadingStatus.success,
              isAuthenticated: true,
            );
          case FailureUseCaseResult():
            state = state.copyWith(
              loadingStatus: LoadingStatus.error,
              error: result.message ?? '로그인에 실패했습니다.',
            );
        }
      } catch (error) {
        print('카카오 로그인 실패: $error');
        state = state.copyWith(
          loadingStatus: LoadingStatus.error,
          error: '카카오 로그인에 실패했습니다.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        loadingStatus: LoadingStatus.error,
        error: e.toString(),
      );
    }
  }
}
