import 'package:json_annotation/json_annotation.dart';

part 'generated/entity_form.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class EntityForm<T> {
  const EntityForm({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final T data;

  factory EntityForm.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromjsonT) =>
      _$EntityFormFromJson(json, fromjsonT);
}



