import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class FortuneState extends Equatable {
  final LoadingStatus loadingStatus;
  final String example;

  const FortuneState({
    required this.loadingStatus,
    required this.example,
  });

  const FortuneState.init()
      : loadingStatus = LoadingStatus.none,
        example = '';

  FortuneState copyWith({
    LoadingStatus? loadingStatus,
    String? example,
  }) =>
      FortuneState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        example: example ?? this.example,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        example,
      ];
}
