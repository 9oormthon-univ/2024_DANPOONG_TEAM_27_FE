import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_lottie/flame_lottie.dart';

import 'character_data.dart';
import 'walking_game.dart';

class HorizontalWalkingGame extends WalkingGame {
  static const double CHARACTER_GAP = 200.0;
  static const double MOVEMENT_SPEED = 100.0;

  // 애니메이션 캐시 저장용
  final Map<String, LottieComposition> _animationCache =
      <String, LottieComposition>{};

  HorizontalWalkingGame(
      {required super.boundarySize,
      required super.characterTypes,
      required super.gameBackground});

  @override
  Future<void> onLoad() async {
    // 카메라, 배경 설정
    camera = CameraComponent(world: world);
    camera.viewport.size = boundarySize;
    camera.viewport.position = Vector2.zero();
    camera.viewfinder.anchor = Anchor.topLeft;

    final Sprite backgroundSprite = await Sprite.load(gameBackground);
    background = SpriteComponent(
      sprite: backgroundSprite,
      size: boundarySize,
      position: Vector2.zero(),
    );
    add(background);

    // 먼저 모든 애니메이션을 로드
    for (final CharacterData character in characterTypes) {
      _animationCache[character.walkAnimation] =
          await AssetLottie(character.walkAnimation).load();
    }

    // 그 다음 캐릭터들 생성
    const int characterCount = 10;
    for (int i = 0; i < characterCount; i++) {
      final CharacterData characterData =
          characterTypes[i % characterTypes.length];
      final double startX = boundarySize.x + (i * CHARACTER_GAP / 2);
      await spawnCharacter(characterData, startX);
    }
  }

  Future<void> spawnCharacter(CharacterData character, [double? startX]) async {
    // 미리 로드된 애니메이션 사용
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

    if (position.x < -size.x) {
      position.x = gameRef.gameSize.x + HorizontalWalkingGame.CHARACTER_GAP;
    }
  }
}
