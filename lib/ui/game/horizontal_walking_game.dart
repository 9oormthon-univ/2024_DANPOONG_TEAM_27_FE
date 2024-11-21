import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_lottie/flame_lottie.dart';

import '../../theme/luckit_colors.dart';
import '../common/consts/assets.dart';
import 'character_data.dart';
import 'walking_game.dart';

class HorizontalWalkingGame extends WalkingGame {
  static const double CHARACTER_GAP = 200.0;
  static const double MOVEMENT_SPEED = 100.0;

  final Map<String, LottieComposition> _animationCache =
      <String, LottieComposition>{};

  HorizontalWalkingGame({
    required super.boundarySize,
    required super.characterTypes,
    required super.gameBackground,
  });

  @override
  Future<void> onLoad() async {
    camera = CameraComponent(world: world);
    camera.viewport.size = boundarySize;
    camera.viewport.position = Vector2.zero();
    camera.viewfinder.anchor = Anchor.topLeft;

    final Sprite backgroundSprite = await Sprite.load(gameBackground);
    background = SpriteComponent(
      sprite: backgroundSprite,
      size: boundarySize,
    );
    add(background);

    final List<CharacterData> orderedCharacters = <CharacterData>[
      characterTypes.firstWhere((CharacterData c) => c.name == '쥐'),
      characterTypes.firstWhere((CharacterData c) => c.name == '소'),
      characterTypes.firstWhere((CharacterData c) => c.name == '호랑이'),
      characterTypes.firstWhere((CharacterData c) => c.name == '토끼'),
      characterTypes.firstWhere((CharacterData c) => c.name == '용'),
      characterTypes.firstWhere((CharacterData c) => c.name == '뱀'),
      characterTypes.firstWhere((CharacterData c) => c.name == '말'),
      characterTypes.firstWhere((CharacterData c) => c.name == '양'),
      characterTypes.firstWhere((CharacterData c) => c.name == '원숭이'),
      characterTypes.firstWhere((CharacterData c) => c.name == '꼬꼬'),
      characterTypes.firstWhere((CharacterData c) => c.name == '개'),
      characterTypes.firstWhere((CharacterData c) => c.name == '돼지'),
      characterTypes.firstWhere((CharacterData c) => c.name == '쥐'),
      characterTypes.firstWhere((CharacterData c) => c.name == '소'),
      characterTypes.firstWhere((CharacterData c) => c.name == '호랑이'),
      characterTypes.firstWhere((CharacterData c) => c.name == '토끼'),
      characterTypes.firstWhere((CharacterData c) => c.name == '용'),
      characterTypes.firstWhere((CharacterData c) => c.name == '뱀'),
      characterTypes.firstWhere((CharacterData c) => c.name == '말'),
      characterTypes.firstWhere((CharacterData c) => c.name == '양'),
      characterTypes.firstWhere((CharacterData c) => c.name == '원숭이'),
      characterTypes.firstWhere((CharacterData c) => c.name == '꼬꼬'),
      characterTypes.firstWhere((CharacterData c) => c.name == '개'),
      characterTypes.firstWhere((CharacterData c) => c.name == '돼지'),
    ];

    for (final CharacterData character in orderedCharacters) {
      _animationCache[character.walkAnimation] =
          await AssetLottie(character.walkAnimation).load();
    }

    const int characterCount = 24;
    for (int i = 0; i < characterCount; i++) {
      final double startX = boundarySize.x + (i * CHARACTER_GAP / 2);
      await spawnCharacter(orderedCharacters[i], startX);
    }
  }

  Future<void> spawnCharacter(CharacterData character, [double? startX]) async {
    final HorizontalLottiePlayer player = HorizontalLottiePlayer(
      character,
      preloadedAnimation: _animationCache[character.walkAnimation]!,
    );
    add(player);

    player
      ..position = Vector2(
        startX ?? boundarySize.x,
        boundarySize.y / 2,
      )
      ..startMoving();
  }
}

class HorizontalLottiePlayer extends PositionComponent
    with HasGameRef<HorizontalWalkingGame> {
  static const double CHARACTER_SIZE = 80.0;
  final CharacterData data;
  final LottieComposition preloadedAnimation;
  late PositionComponent characterContainer;
  late LottieComponent walkingAnimation;

  HorizontalLottiePlayer(this.data, {required this.preloadedAnimation}) {
    size = Vector2.all(CHARACTER_SIZE);
  }

  @override
  Future<void> onLoad() async {
    characterContainer = PositionComponent(
      size: size,
      position: Vector2.zero(),
    );
    add(characterContainer);

    walkingAnimation = LottieComponent(
      preloadedAnimation,
      size: size,
      repeating: true,
    );

    characterContainer.add(walkingAnimation);
  }

  void startMoving() {
    // 필요한 경우 초기화 로직
  }

  @override
  void update(double dt) {
    position.x -= HorizontalWalkingGame.MOVEMENT_SPEED * dt;
  }
}
