import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';
import '../../domain/fortune/model/fortune_model.dart';
import '../../ui/onboarding/onboarding_state.dart';

class MyInfoState extends Equatable {
  final LoadingStatus getUserLoginInfoLoadingStatus;
  final LoadingStatus getUserBirthInfoLoadingStatus;
  final LoadingStatus getUserFortuneInfoLoadingStatus;
  final String userName;
  final GenderType gender;
  final BirthType solarOrLunar;
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final bool unknownTime;
  final FortuneModel userFortune;

  const MyInfoState({
    required this.getUserLoginInfoLoadingStatus,
    required this.getUserBirthInfoLoadingStatus,
    required this.getUserFortuneInfoLoadingStatus,
    required this.userName,
    required this.gender,
    required this.solarOrLunar,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.unknownTime,
    required this.userFortune,
  });

  MyInfoState.init()
      : getUserBirthInfoLoadingStatus = LoadingStatus.none,
        getUserFortuneInfoLoadingStatus = LoadingStatus.none,
        getUserLoginInfoLoadingStatus = LoadingStatus.none,
        userName = '',
        gender = GenderType.none,
        solarOrLunar = BirthType.none,
        year = '',
        month = '',
        day = '',
        hour = '',
        minute = '',
        unknownTime = true,
        userFortune = FortuneModel.init();

  MyInfoState copyWith({
    LoadingStatus? getUserBirthInfoLoadingStatus,
    LoadingStatus? getUserFortuneInfoLoadingStatus,
    LoadingStatus? getUserLoginInfoLoadingStatus,
    String? userName,
    GenderType? gender,
    BirthType? solarOrLunar,
    String? year,
    String? month,
    String? day,
    String? hour,
    String? minute,
    bool? unknownTime,
    FortuneModel? userFortune,
  }) =>
      MyInfoState(
        getUserBirthInfoLoadingStatus:
            getUserBirthInfoLoadingStatus ?? this.getUserBirthInfoLoadingStatus,
        getUserFortuneInfoLoadingStatus: getUserFortuneInfoLoadingStatus ??
            this.getUserFortuneInfoLoadingStatus,
        getUserLoginInfoLoadingStatus:
            getUserLoginInfoLoadingStatus ?? this.getUserLoginInfoLoadingStatus,
        userName: userName ?? this.userName,
        gender: gender ?? this.gender,
        solarOrLunar: solarOrLunar ?? this.solarOrLunar,
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        unknownTime: unknownTime ?? this.unknownTime,
        userFortune: userFortune ?? this.userFortune,
      );

  @override
  List<Object?> get props => <Object?>[
        getUserBirthInfoLoadingStatus,
        getUserFortuneInfoLoadingStatus,
        getUserLoginInfoLoadingStatus,
        userName,
        solarOrLunar,
        year,
        month,
        day,
        hour,
        minute,
        unknownTime,
        gender,
        userFortune,
      ];
}
