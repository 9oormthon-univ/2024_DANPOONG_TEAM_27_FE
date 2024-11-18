import 'package:json_annotation/json_annotation.dart';

part 'generated/file_entity.g.dart';

@JsonSerializable()
class FileEntity {
  const FileEntity({
    required this.id,
    required this.logicalName,
    required this.physicalPath,
  });

  final int? id;
  final String logicalName;
  final String physicalPath;

  factory FileEntity.fromJson(Map<String, dynamic> json) =>
      _$FileEntityFromJson(json);
}
