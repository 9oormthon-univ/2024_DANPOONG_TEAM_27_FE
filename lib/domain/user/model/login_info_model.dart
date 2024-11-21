import 'package:equatable/equatable.dart';

import '../../../data/user/entity/login_info_entity.dart';

class LoginInfoModel extends Equatable {
  final String email;
  final String name;
  final String profileImageUrl;

  const LoginInfoModel({
    required this.email,
    required this.name,
    required this.profileImageUrl,
  });

  factory LoginInfoModel.fromEntity({
    required LoginInfoEntity entity,
  }) =>
      LoginInfoModel(
        email: entity.email,
        name: entity.name,
        profileImageUrl: entity.profileImageUrl,
      );

  @override
  List<Object?> get props => <Object?>[
        email,
        name,
        profileImageUrl,
      ];
}
