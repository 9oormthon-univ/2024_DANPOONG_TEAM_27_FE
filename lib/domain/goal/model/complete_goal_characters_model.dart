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
  final List<CharacterBoxWidget> goalCharacters;

  const CompleteGoalCharactersModel({
    required this.goalCharacters,
  });

  factory CompleteGoalCharactersModel.fromEntity({required List<int> entity}) =>
      CompleteGoalCharactersModel(
        goalCharacters: List<CharacterBoxWidget>.generate(
          entity.length,
          (int index) => CharacterBoxWidget(
            number: entity[index].toString(),
            frame: frames[index],
          ),
        ),
      );
}
