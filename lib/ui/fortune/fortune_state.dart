import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class FortuneState extends Equatable {
  final LoadingStatus loadingStatus;
  final String selectdTitle;
  final int selectedTitleScore;

  const FortuneState({
    required this.loadingStatus,
    required this.selectdTitle,
    required this.selectedTitleScore,
  });

  const FortuneState.init()
      : loadingStatus = LoadingStatus.none,
        selectdTitle = '총운',
        selectedTitleScore = 0;

  FortuneState copyWith({
    LoadingStatus? loadingStatus,
    String? selectdTitle,
    int? selectedTitleScore,
  }) =>
      FortuneState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        selectdTitle: selectdTitle ?? this.selectdTitle,
        selectedTitleScore: selectedTitleScore ?? this.selectedTitleScore,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        selectdTitle,
        selectedTitleScore,
      ];
}
