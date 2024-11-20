import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'character_data.dart';
import 'lottie_player.dart';

class WalkingGame extends FlameGame {
  final Random random = Random();
  final Vector2 boundarySize;
  final List<CharacterData> characterTypes;
  final String gameBackground;
  late SpriteComponent background;

  WalkingGame(
      {required this.boundarySize,
      required this.characterTypes,
      required this.gameBackground})
      : super(world: World());

  @override
  Future<void> onLoad() async {
    camera = CameraComponent(world: world);
    camera.viewport.size = boundarySize;
    camera.viewport.position = Vector2.zero();
    camera.viewfinder.anchor = Anchor.topLeft;

    // 배경 이미지 로드 및 추가
    final Sprite backgroundSprite = await Sprite.load(gameBackground);
    background = SpriteComponent(
      sprite: backgroundSprite,
      size: boundarySize,
      position: Vector2.zero(),
    );
    world.add(background);

    const double margin = 60.0;
    final Vector2 safeArea = Vector2(
      boundarySize.x - margin * 2,
      boundarySize.y - margin * 2,
    );

    for (final CharacterData characterData in characterTypes) {
      final LottiePlayer player = await LottiePlayer.create(characterData);
      world.add(player);

      player.position = Vector2(
        margin + random.nextDouble() * safeArea.x,
        margin + random.nextDouble() * safeArea.y,
      );

      await player.isReady.future;
      player.startMoving();
    }
  }

  Future<void> updateBackground(
      String newGameBackground, bool isLandscape) async {
    final Sprite newSprite = await Sprite.load(newGameBackground);
    background.sprite = newSprite;

    // Swap width and height for landscape mode
    if (isLandscape) {
      camera.viewport.size = Vector2(boundarySize.y, boundarySize.x);
      background.size = Vector2(boundarySize.y, boundarySize.x);
    } else {
      camera.viewport.size = boundarySize;
      background.size = boundarySize;
    }
    camera.viewport.position = Vector2.zero();
  }

  Vector2 get gameSize => boundarySize;
}
