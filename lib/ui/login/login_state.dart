import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class LoginState extends Equatable {
  final LoadingStatus loadingStatus;
  final String? error;
  final bool isAuthenticated;

  const LoginState({
    required this.loadingStatus,
    required this.isAuthenticated,
    this.error,
  });

  const LoginState.init()
      : loadingStatus = LoadingStatus.none,
        error = null,
        isAuthenticated = false;

  LoginState copyWith({
    LoadingStatus? loadingStatus,
    String? error,
    bool? isAuthenticated,
  }) =>
      LoginState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        error: error ?? this.error,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      );

  @override
  List<Object?> get props => <Object?>[
        loadingStatus,
        error,
        isAuthenticated,
      ];
}
