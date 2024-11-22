import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class LoginState extends Equatable {
  final LoadingStatus kakaoOauthLoadingStatus;
  final String? error;
  final bool isAuthenticated;

  const LoginState({
    required this.kakaoOauthLoadingStatus,
    required this.isAuthenticated,
    this.error,
  });

  const LoginState.init()
      : kakaoOauthLoadingStatus = LoadingStatus.none,
        error = null,
        isAuthenticated = false;

  LoginState copyWith({
    LoadingStatus? kakaoOauthLoadingStatus,
    String? error,
    bool? isAuthenticated,
  }) =>
      LoginState(
        kakaoOauthLoadingStatus:
            kakaoOauthLoadingStatus ?? this.kakaoOauthLoadingStatus,
        error: error ?? this.error,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      );

  @override
  List<Object?> get props => <Object?>[
        kakaoOauthLoadingStatus,
        error,
        isAuthenticated,
      ];
}
