import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/consts/assets.dart';
import '../game/character_data.dart';

class FarmCharactersNotifier extends StateNotifier<List<CharacterData>> {
  FarmCharactersNotifier()
      : super(<CharacterData>[
          CharacterData(
            idleAnimation: Assets.noShadowChickenStop,
            walkAnimation: Assets.noShadowChickenMove,
            name: '꼬꼬',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowPigStop,
            walkAnimation: Assets.noShadowPigMove,
            name: '돼지',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowHorseStop,
            walkAnimation: Assets.noShadowHorseMove,
            name: '말',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowCowStop,
            walkAnimation: Assets.noShadowCowMove,
            name: '소',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowDogStop,
            walkAnimation: Assets.noShadowDogMove,
            name: '개',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowDragonStop,
            walkAnimation: Assets.noShadowDragonMove,
            name: '용',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowMonkeyStop,
            walkAnimation: Assets.noShadowMonkeyMove,
            name: '원숭이',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowRabbitStop,
            walkAnimation: Assets.noShadowRabbitMove,
            name: '토끼',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowSheepStop,
            walkAnimation: Assets.noShadowSheepMove,
            name: '양',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowSnakeStop,
            walkAnimation: Assets.noShadowSnakeMove,
            name: '뱀',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowTigerStop,
            walkAnimation: Assets.noShadowTigerMove,
            name: '호랑이',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowMouseStop,
            walkAnimation: Assets.noShadowMouseMove,
            name: '쥐',
          ),
        ]);

  void addCharacter(CharacterData character) {
    state = <CharacterData>[...state, character];
  }

  void removeCharacter(int index) {
    state = <CharacterData>[...state]..removeAt(index);
  }
}

// Provider 정의
final StateNotifierProvider<FarmCharactersNotifier, List<CharacterData>>
    farmCharactersProvider =
    StateNotifierProvider<FarmCharactersNotifier, List<CharacterData>>(
        (StateNotifierProviderRef<FarmCharactersNotifier, List<CharacterData>>
                ref) =>
            FarmCharactersNotifier());
