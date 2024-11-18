import 'package:json_annotation/json_annotation.dart';

class DateTimeJsonConverter extends JsonConverter<DateTime, String> {
  const DateTimeJsonConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();

  @override
  String toJson(DateTime object) => object.toUtc().toString();
}
