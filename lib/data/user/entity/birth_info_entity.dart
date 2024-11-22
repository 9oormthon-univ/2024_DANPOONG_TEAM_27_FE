import 'package:json_annotation/json_annotation.dart';
part 'generated/birth_info_entity.g.dart';

@JsonSerializable()
class BirthInfoEntity {
  const BirthInfoEntity({
    required this.gender,
    required this.solarOrLunar,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
  });

  final String gender;
  final String solarOrLunar;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;

  factory BirthInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$BirthInfoEntityFromJson(json);
}
