import 'package:json_annotation/json_annotation.dart';
part 'generated/register_birth_info_request_body.g.dart';

@JsonSerializable()
class RegisterBirthInfoRequestBody {
  const RegisterBirthInfoRequestBody({
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

  factory RegisterBirthInfoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterBirthInfoRequestBodyFromJson(json);
}
