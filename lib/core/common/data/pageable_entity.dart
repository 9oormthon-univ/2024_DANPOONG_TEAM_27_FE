import 'package:json_annotation/json_annotation.dart';

part 'generated/pageable_entity.g.dart';

@JsonSerializable()
class PageableEntity {
  const PageableEntity({
    required this.page,
    required this.size,
    required this.totalPages,
    required this.totalElements,
    required this.isEnd,
  });

  final int page;
  final int size;
  final int totalPages;
  final int totalElements;
  final bool isEnd;

  factory PageableEntity.fromJson(Map<String, dynamic> json) =>
      _$PageableEntityFromJson(json);
}
