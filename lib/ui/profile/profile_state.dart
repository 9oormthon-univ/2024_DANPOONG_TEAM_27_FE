import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';

class ProfileState extends Equatable {
  final bool opened;

  // status
  final LoadingStatus loadingProfile;
  final bool isProfileButtonsOpen;

  // user info
  final String name;
  final String gender;
  final String solarOrLunar;
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final bool unknownTime;

  const ProfileState({
    required this.opened,
    required this.loadingProfile,
    required this.isProfileButtonsOpen,
    required this.name,
    required this.gender,
    required this.solarOrLunar,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.unknownTime,
  });

  const ProfileState.init()
      : opened = false,
        loadingProfile = LoadingStatus.none,
        isProfileButtonsOpen = false,
        name = '',
        gender = '',
        solarOrLunar = '',
        year = '',
        month = '',
        day = '',
        hour = '',
        minute = '',
        unknownTime = false;

  ProfileState copyWith({
    bool? opened,
    LoadingStatus? loadingProfile,
    bool? isProfileButtonsOpen,
    String? name,
    String? gender,
    String? solarOrLunar,
    String? year,
    String? month,
    String? day,
    String? hour,
    String? minute,
    bool? unknownTime,
  }) =>
      ProfileState(
        opened: opened ?? this.opened,
        loadingProfile: loadingProfile ?? this.loadingProfile,
        isProfileButtonsOpen: isProfileButtonsOpen ?? this.isProfileButtonsOpen,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        solarOrLunar: solarOrLunar ?? this.solarOrLunar,
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        unknownTime: unknownTime ?? this.unknownTime,
      );

  @override
  List<Object> get props => <Object>[
        opened,
        loadingProfile,
        isProfileButtonsOpen,
        name,
        gender,
        solarOrLunar,
        year,
        month,
        day,
        hour,
        minute,
        unknownTime,
      ];
}
