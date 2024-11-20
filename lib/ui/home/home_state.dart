import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class HomeState extends Equatable {
  final LoadingStatus loadingStatus;
  final bool isGoalEditing;
  final bool isGoalButtonOpen;
  final String example;

  const HomeState({
    required this.loadingStatus,
    required this.isGoalEditing,
    required this.isGoalButtonOpen,
    required this.example,
  });

  const HomeState.init()
      : loadingStatus = LoadingStatus.none,
        isGoalEditing = false,
        isGoalButtonOpen = false,
        example = '';

  HomeState copyWith({
    LoadingStatus? loadingStatus,
    bool? isGoalEditing,
    bool? isGoalButtonOpen,
    String? example,
  }) =>
      HomeState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        isGoalEditing: isGoalEditing ?? this.isGoalEditing,
        isGoalButtonOpen: isGoalButtonOpen ?? this.isGoalButtonOpen,
        example: example ?? this.example,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        isGoalEditing,
        isGoalButtonOpen,
        example,
      ];
}
