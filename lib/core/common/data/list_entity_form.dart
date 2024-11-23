import 'package:json_annotation/json_annotation.dart';

part 'generated/list_entity_form.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListEntityForm<T> {
  const ListEntityForm({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final List<T> data;

  factory ListEntityForm.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromjsonT) =>
      _$ListEntityFormFromJson(json, fromjsonT);
}
