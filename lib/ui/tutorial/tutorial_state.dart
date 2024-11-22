import 'package:equatable/equatable.dart';

class TutorialState extends Equatable {
  final bool activated;

  const TutorialState({
    required this.activated,
  });

  const TutorialState.init() : activated = false;

  TutorialState copyWith({
    bool? activated,
  }) =>
      TutorialState(
        activated: activated ?? this.activated,
      );

  @override
  List<Object> get props => <Object>[activated];
}
