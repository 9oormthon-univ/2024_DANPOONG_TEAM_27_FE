import '../../../domain/goal/model/complete_goal_characters_model.dart';
import '../../common/consts/assets.dart';
import '../../farm/widget/landscape_character_box.dart';
import '../widgets/profile_character_box_widget.dart';

final List<CharacterBoxWidget> data = <CharacterBoxWidget>[
   const CharacterBoxWidget(number: '12', frame: Assets.transparentMouseFrame),
   const CharacterBoxWidget(number: '9', frame: Assets.transparentCowFrame),
   const CharacterBoxWidget(number: '5', frame: Assets.transparentTigerFrame),
   const CharacterBoxWidget(number: '6', frame: Assets.transparentRabbitFrame),
   const CharacterBoxWidget(number: '9', frame: Assets.transparentDragonFrame),
   const CharacterBoxWidget(number: '4', frame: Assets.transparentSnakeFrame),
   const CharacterBoxWidget(number: '5', frame: Assets.transparentHorseFrame),
   const CharacterBoxWidget(number: '3', frame: Assets.transparentSheepFrame),
   const CharacterBoxWidget(number: '4', frame: Assets.transparentMonkeyFrame),
   const CharacterBoxWidget(number: '7', frame: Assets.transparentChickenFrame),
   const CharacterBoxWidget(number: '8', frame: Assets.transparentDogFrame),
   const CharacterBoxWidget(number: '2', frame: Assets.transparentPigFrame),
];

final List<LandscapeCharacterBox> data_landscape = <LandscapeCharacterBox>[
   const LandscapeCharacterBox(number: '12', frame: Assets.landscapeMouseFrame),
   const LandscapeCharacterBox(number: '9', frame: Assets.landscapeCowFrame),
   const LandscapeCharacterBox(number: '5', frame: Assets.landscapeTigerFrame),
   const LandscapeCharacterBox(number: '6', frame: Assets.landscapeRabbitFrame),
   const LandscapeCharacterBox(number: '9', frame: Assets.landscapeDragonFrame),
   const LandscapeCharacterBox(number: '4', frame: Assets.landscapeSnakeFrame),
   const LandscapeCharacterBox(number: '5', frame: Assets.landscapeHorseFrame),
   const LandscapeCharacterBox(number: '3', frame: Assets.landscapeSheepFrame),
   const LandscapeCharacterBox(number: '4', frame: Assets.landscapeMonkeyFrame),
   const LandscapeCharacterBox(number: '7', frame: Assets.landscapeChickenFrame),
   const LandscapeCharacterBox(number: '8', frame: Assets.landscapeDogFrame),
   const LandscapeCharacterBox(number: '2', frame: Assets.landscapePigFrame),
];

final CompleteGoalCharactersModel datadaa = CompleteGoalCharactersModel(
   startYear: 2024,
   startMonth: 11,
   startDay: 15,
   endYear: 2024,
   endMonth: 12,
   endDay: 15,
   goalCharacters: <CharacterBoxWidget>[
      const CharacterBoxWidget(number: '1', frame: Assets.transparentMouseFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentCowFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentTigerFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentRabbitFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentDragonFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentSnakeFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentHorseFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentSheepFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentMonkeyFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentChickenFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentDogFrame),
      const CharacterBoxWidget(number: '1', frame: Assets.transparentPigFrame),
   ],
);
