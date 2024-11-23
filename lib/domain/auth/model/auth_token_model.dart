import 'package:equatable/equatable.dart';

import '../../../data/auth/entity/auth_token_entity.dart';

class AuthTokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final bool isFirstLogin;

  const AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.isFirstLogin,
  });

  factory AuthTokenModel.fromEntity({required AuthTokenEntity entity}) =>
      AuthTokenModel(
        accessToken: entity.data.accessToken,
        refreshToken: entity.data.refreshToken,
        isFirstLogin: entity.message != '기존에 있는 유저입니다.',
      );

  @override
  List<Object?> get props => <Object?>[accessToken, refreshToken];
}
