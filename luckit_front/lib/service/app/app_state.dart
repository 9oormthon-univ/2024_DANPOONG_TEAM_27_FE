import 'package:equatable/equatable.dart';

/// 전역으로 관리하는 상태 EX) 로그인 상태
class AppState extends Equatable {
  final bool isSignedIn;

  const AppState({
    required this.isSignedIn,
  });

  const AppState.init() : isSignedIn = false;

  AppState copyWith({
    bool? isSignedIn,
  }) =>
      AppState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
      );

  @override
  List<Object?> get props => <Object?>[isSignedIn];
}
