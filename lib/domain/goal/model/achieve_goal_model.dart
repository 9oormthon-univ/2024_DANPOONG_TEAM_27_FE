import '../../../data/goal/entity/achieve_goal_entity.dart';
import '../../../ui/common/consts/assets.dart';

class AchieveGoalModel {
  final int startYear;
  final int startMonth;
  final int startDay;
  final int endYear;
  final int endMonth;
  final int endDay;
  final List<int> countAnimals;

  const AchieveGoalModel({
    required this.countAnimals,
    required this.endDay,
    required this.endMonth,
    required this.endYear,
    required this.startMonth,
    required this.startYear,
    required this.startDay,
  });

  static final List<String> frames = <String>[
    Assets.landscapeMouseFrame,
    Assets.landscapeCowFrame,
    Assets.landscapeTigerFrame,
    Assets.landscapeRabbitFrame,
    Assets.landscapeDragonFrame,
    Assets.landscapeSnakeFrame,
    Assets.landscapeHorseFrame,
    Assets.landscapeSheepFrame,
    Assets.landscapeMonkeyFrame,
    Assets.landscapeChickenFrame,
    Assets.landscapeDogFrame,
    Assets.landscapePigFrame,
  ];

  factory AchieveGoalModel.fromEntity({
    required AchieveGoalEntity entity,
  }) =>
      AchieveGoalModel(
        endDay: entity.endDateDay,
        endMonth: entity.endDateMonth,
        endYear: entity.endDateYear,
        startDay: entity.startDateDay,
        startMonth: entity.startDateMonth,
        startYear: entity.startDateYear,
        countAnimals: entity.countAnimals,
      );
}