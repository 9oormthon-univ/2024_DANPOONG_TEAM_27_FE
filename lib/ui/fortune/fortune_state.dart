import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../../../domain/fortune/model/fortune_model.dart';
class FortuneState extends Equatable {
  final LoadingStatus loadingStatus;
  final String selectedTitle;
  final FortuneModel? fortune;

  const FortuneState({
    required this.loadingStatus,
    required this.selectedTitle,
    required this.fortune,
  });

  const FortuneState.init()
      : loadingStatus = LoadingStatus.none,
        selectedTitle = '총운',
        fortune = null;

  FortuneState copyWith({
    LoadingStatus? loadingStatus,
    String? selectdTitle,
    FortuneModel? fortune,
  }) =>
      FortuneState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        selectedTitle: selectdTitle ?? this.selectedTitle,
        fortune: fortune ?? this.fortune,
      );

  @override
  List<Object> get props => <Object>[
        loadingStatus,
        selectedTitle,
        fortune!,
      ];
}
