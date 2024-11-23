import 'package:equatable/equatable.dart';

/// 전역으로 관리하는 상태 EX) 로그인 상태
class AppState extends Equatable {
  final bool isSignedIn;
  final bool isFirstLogin;

  const AppState({
    required this.isSignedIn,
    required this.isFirstLogin,
  });

  const AppState.init()
      : isSignedIn = false,
        isFirstLogin = true;

  AppState copyWith({
    bool? isSignedIn,
    bool? isFirstLogin,
  }) =>
      AppState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
        isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      );

  @override
  List<Object?> get props => <Object?>[
        isSignedIn,
        isFirstLogin,
      ];
}
