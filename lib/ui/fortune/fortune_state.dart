import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class FortuneState extends Equatable {
  final LoadingStatus loadingStatus;
  final String selectdTitle;

  const FortuneState({
    required this.loadingStatus,
    required this.selectdTitle,
  });

  const FortuneState.init()
      : loadingStatus = LoadingStatus.none,
        selectdTitle = '총운';

  FortuneState copyWith({
    LoadingStatus? loadingStatus,
    String? selectdTitle,
  }) =>
      FortuneState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        selectdTitle: selectdTitle ?? this.selectdTitle,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        selectdTitle,
      ];
}
