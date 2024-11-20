import 'package:booklog/ui/game/character_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/consts/assets.dart';

class FarmCharactersNotifier extends StateNotifier<List<CharacterData>> {
  FarmCharactersNotifier() : super([
    CharacterData(
      idleAnimation: Assets.chickenStop,
      walkAnimation: Assets.chickenMove,
      name: '꼬꼬',
    ),
    CharacterData(
      idleAnimation: Assets.pigStop,
      walkAnimation: Assets.pigMove,
      name: '돼지',
    ),
    CharacterData(
      idleAnimation: Assets.horseStop,
      walkAnimation: Assets.horseMove,
      name: '말',
    ),
    CharacterData(
      idleAnimation: Assets.cowStop,
      walkAnimation: Assets.cowMove,
      name: '소',
    ),
    CharacterData(
      idleAnimation: Assets.dogStop,
      walkAnimation: Assets.dogMove,
      name: '개',
    ),
    CharacterData(
      idleAnimation: Assets.dragonStop,
      walkAnimation: Assets.dragonMove,
      name: '용',
    ),
    CharacterData(
      idleAnimation: Assets.monkeyStop,
      walkAnimation: Assets.monkeyMove,
      name: '원숭이',
    ),
    CharacterData(
      idleAnimation: Assets.rabbitStop,
      walkAnimation: Assets.rabbitMove,
      name: '토끼',
    ),
    CharacterData(
      idleAnimation: Assets.sheepStop,
      walkAnimation: Assets.sheepMove,
      name: '양',
    ),
    CharacterData(
      idleAnimation: Assets.snakeStop,
      walkAnimation: Assets.snakeMove,
      name: '뱀',
    ),
    CharacterData(
      idleAnimation: Assets.tigerStop,
      walkAnimation: Assets.tigerMove,
      name: '호랑이',
    ),
    CharacterData(
      idleAnimation: Assets.mouseStop,
      walkAnimation: Assets.mouseMove,
      name: '쥐',
    ),
  ]);

  void addCharacter(CharacterData character) {
    state = [...state, character];
  }

  void removeCharacter(int index) {
    state = [...state]..removeAt(index);
  }
}

// Provider 정의
final farmCharactersProvider = StateNotifierProvider<FarmCharactersNotifier, List<CharacterData>>((ref) {
  return FarmCharactersNotifier();
});