import 'package:equatable/equatable.dart';

import '../../../data/auth/entity/auth_token_entity.dart';

class AuthTokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenModel.fromEntity({required AuthTokenEntity entity}) =>
      AuthTokenModel(
        accessToken: entity.data.accessToken,
        refreshToken: entity.data.refreshToken,
      );

  @override
  List<Object?> get props => <Object?>[accessToken, refreshToken];
}
