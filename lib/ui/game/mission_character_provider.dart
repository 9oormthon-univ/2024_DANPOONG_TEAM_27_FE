import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/consts/assets.dart';
import 'character_data.dart';

class MissionCharactersNotifier extends StateNotifier<List<CharacterData>> {
  MissionCharactersNotifier()
      : super(<CharacterData>[
          CharacterData(
            idleAnimation: Assets.noShadowPigStop,
            walkAnimation: Assets.noShadowPigMove,
            name: '돼지',
          ),
          CharacterData(
            idleAnimation: Assets.noShadowRabbitStop,
            walkAnimation: Assets.noShadowRabbitMove,
            name: '토끼',
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
final StateNotifierProvider<MissionCharactersNotifier, List<CharacterData>>
    missionCharactersProvider =
    StateNotifierProvider<MissionCharactersNotifier, List<CharacterData>>(
        (StateNotifierProviderRef<MissionCharactersNotifier,
                    List<CharacterData>>
                ref) =>
            MissionCharactersNotifier());
