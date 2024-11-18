class AuthTokenEntity {
  final String accessToken;
  final String refreshToken;

  const AuthTokenEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenEntity.fromJson(Map<String, dynamic> json) =>
      AuthTokenEntity(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
      );
}
