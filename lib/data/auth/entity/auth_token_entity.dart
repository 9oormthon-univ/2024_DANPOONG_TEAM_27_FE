import 'package:json_annotation/json_annotation.dart';
part 'generated/auth_token_entity.g.dart';

@JsonSerializable()
class AuthTokenEntity {
  const AuthTokenEntity({
    required this.message,
    required this.data,
  });
  final String message;
  final TokenData data;

  factory AuthTokenEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenEntityFromJson(json);
}

@JsonSerializable()
class TokenData {
  const TokenData({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);
}
