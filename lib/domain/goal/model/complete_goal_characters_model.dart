import '../../../data/goal/entity/goal_detail_entity.dart';
import '../../../ui/common/consts/assets.dart';
import '../../../ui/profile/widgets/profile_character_box_widget.dart';

final List<String> frames = <String>[
  Assets.transparentMouseFrame,
  Assets.transparentCowFrame,
  Assets.transparentTigerFrame,
  Assets.transparentRabbitFrame,
  Assets.transparentDragonFrame,
  Assets.transparentSnakeFrame,
  Assets.transparentHorseFrame,
  Assets.transparentSheepFrame,
  Assets.transparentMonkeyFrame,
  Assets.transparentChickenFrame,
  Assets.transparentDogFrame,
  Assets.transparentPigFrame,
];

class CompleteGoalCharactersModel {
  final int startYear;
  final int startMonth;
  final int startDay;
  final int endYear;
  final int endMonth;
  final int endDay;
  final List<CharacterBoxWidget> goalCharacters;

  const CompleteGoalCharactersModel({
    required this.goalCharacters,
    required this.endDay,
    required this.endMonth,
    required this.endYear,
    required this.startMonth,
    required this.startYear,
    required this.startDay,
  });

  factory CompleteGoalCharactersModel.fromEntity({
    required GoalDetailEntity entity,
  }) =>
      CompleteGoalCharactersModel(
        endDay: entity.endDateDay,
        endMonth: entity.endDateMonth,
        endYear: entity.endDateYear,
        startDay: entity.startDateDay,
        startMonth: entity.startDateMonth,
        startYear: entity.startDateYear,
        goalCharacters: List<CharacterBoxWidget>.generate(
          entity.countAnimals.length,
          (int index) => CharacterBoxWidget(
            number: entity.countAnimals[index].toString(),
            frame: frames[index],
          ),
        ),
      );
}
