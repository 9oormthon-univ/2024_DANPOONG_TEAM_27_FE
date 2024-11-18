import 'package:json_annotation/json_annotation.dart';
part 'generated/example_entity.g.dart';

@JsonSerializable()
class ExampleEntity {
  const ExampleEntity({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  factory ExampleEntity.fromJson(Map<String, dynamic> json) =>
      _$ExampleEntityFromJson(json);
}
