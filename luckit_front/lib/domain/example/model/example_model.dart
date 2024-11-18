import 'package:equatable/equatable.dart';

import '../../../data/example/entity/example_entity.dart';

class ExampleModel extends Equatable {
  final String id;
  final String title;

  const ExampleModel({
    required this.id,
    required this.title,
  });

  factory ExampleModel.fromEntity({
    required ExampleEntity entity,
  }) =>
      ExampleModel(
        id: entity.id,
        title: entity.title,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
      ];
}
