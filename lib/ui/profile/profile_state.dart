import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final bool opened;

  const ProfileState({
    required this.opened,
  });

  const ProfileState.init() : opened = false;

  ProfileState copyWith({
    bool? opened,
  }) =>
      ProfileState(
        opened: opened ?? this.opened,
      );

  @override
  List<Object> get props => <Object>[];
}
