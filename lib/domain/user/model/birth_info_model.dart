import 'package:equatable/equatable.dart';

import '../../../data/user/entity/birth_info_entity.dart';

class BirthInfoModel extends Equatable {
  final String gender;
  final String solarOrLunar;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final bool unknownTime;

  const BirthInfoModel({
    required this.gender,
    required this.solarOrLunar,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.unknownTime,
  });

  factory BirthInfoModel.fromEntity({
    required BirthInfoEntity entity,
  }) =>
      BirthInfoModel(
        gender: entity.gender,
        solarOrLunar: entity.solarOrLunar,
        year: entity.year,
        month: entity.month,
        day: entity.day,
        hour: entity.hour,
        minute: entity.minute,
        unknownTime: entity.unknownTime,
      );

  @override
  List<Object?> get props => <Object?>[
        gender,
        solarOrLunar,
        year,
        month,
        day,
        hour,
        minute,
        unknownTime,
      ];
}
