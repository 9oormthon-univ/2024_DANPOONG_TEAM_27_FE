import 'package:json_annotation/json_annotation.dart';
part 'generated/login_info_entity.g.dart';

@JsonSerializable()
class LoginInfoEntity {
  const LoginInfoEntity({
    required this.email,
    required this.name,
    required this.profileImageUrl,
  });

  final String email;
  final String name;
  final String profileImageUrl;

  factory LoginInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoEntityFromJson(json);
}
