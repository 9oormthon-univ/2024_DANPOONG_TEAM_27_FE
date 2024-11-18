import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class HomeState extends Equatable {
  final LoadingStatus loadingStatus;
  final String example;

  const HomeState({
    required this.loadingStatus,
    required this.example,
  });

  const HomeState.init()
      : loadingStatus = LoadingStatus.none,
        example = '';

  HomeState copyWith({
    LoadingStatus? loadingStatus,
    String? example,
  }) =>
      HomeState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        example: example ?? this.example,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        example,
      ];
}
