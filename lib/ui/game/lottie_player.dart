// 캐릭터 상태 열거형
import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_lottie/flame_lottie.dart';

import 'character_data.dart';
import 'walking_game.dart';

enum CharacterState { idle, moving }

// Lottie 플레이어 컴포넌트
class LottiePlayer extends PositionComponent with HasGameRef<WalkingGame> {
  final CharacterData data;
  Vector2 targetPosition = Vector2.zero();
  bool reachedTarget = false;
  bool facingRight = true;
  CharacterState state = CharacterState.idle;
  final Random random = Random();

  // 모든 캐릭터에 대한 고정 값 설정
  static const double CHARACTER_SIZE = 50.0;
  static const double CHARACTER_SPEED = 80.0;

  late PositionComponent characterContainer;

  double stateTimer = 0;
  double currentStateDuration = 0;
  double moveTimer = 0;

  LottieComponent? idleAnimation;
  LottieComponent? walkingAnimation;
  LottieComponent? currentAnimation;

  final Completer<void> isReady = Completer<void>();

  LottiePlayer(this.data) : super(size: Vector2.all(CHARACTER_SIZE));

  static Future<LottiePlayer> create(CharacterData data) async {
    final LottiePlayer player = LottiePlayer(data);
    return player;
  }

  @override
  Future<void> onLoad() async {
    try {
      characterContainer = PositionComponent(
        size: size,
        position: Vector2.zero(),
      );
      add(characterContainer);

      final LottieComposition idleComposition =
      await AssetLottie(data.idleAnimation).load();
      final LottieComposition walkComposition =
      await AssetLottie(data.walkAnimation).load();

      idleAnimation = LottieComponent(
        idleComposition,
        size: size,
        repeating: true,
      );

      walkingAnimation = LottieComponent(
        walkComposition,
        size: size,
        repeating: true,
      );

      currentAnimation = idleAnimation;
      characterContainer.add(currentAnimation!);

      setNewTargetPosition();
      isReady.complete();
    } catch (e) {
      print('Error loading animations for character: $e');
      isReady.completeError(e);
      rethrow;
    }
  }

  void _switchAnimation(CharacterState newState) {
    if (currentAnimation != null) {
      characterContainer.remove(currentAnimation!);
    }

    if (newState == CharacterState.idle) {
      currentAnimation = idleAnimation;
    } else {
      currentAnimation = walkingAnimation;
    }

    if (currentAnimation != null) {
      characterContainer.add(currentAnimation!);
    }
  }

  void startMoving() {
    if (state != CharacterState.moving) {
      state = CharacterState.moving;
      _switchAnimation(CharacterState.moving);
      if (reachedTarget) {
        setNewTargetPosition();
      }
      currentStateDuration = getRandomDuration();
      stateTimer = 0;
    }
  }

  void startIdle() {
    if (state != CharacterState.idle) {
      state = CharacterState.idle;
      _switchAnimation(CharacterState.idle);
      currentStateDuration = getRandomDuration();
      stateTimer = 0;
    }
  }

  double getRandomDuration() => switch (state) {
    CharacterState.idle => 1.0 + random.nextDouble() * 2.0,
    CharacterState.moving => 2.0 + random.nextDouble() * 3.0,
  };

  void setNewTargetPosition() {
    final double margin = size.x;
    double newX;
    double newY;
    do {
      newX = margin + random.nextDouble() * (gameRef.gameSize.x - margin * 2);
      newY = margin + random.nextDouble() * (gameRef.gameSize.y - margin * 2);
    } while ((Vector2(newX, newY) - position).length < 100);

    targetPosition = Vector2(newX, newY);
    reachedTarget = false;
    moveTimer = 0;
  }

  void updateDirection(Vector2 direction) {
    if (direction.x > 0 && !facingRight) {
      facingRight = true;
      characterContainer.scale.x = -1;
    } else if (direction.x < 0 && facingRight) {
      facingRight = false;
      characterContainer.scale.x = 1;
    }
  }

  @override
  void update(double dt) {
    stateTimer += dt;
    moveTimer += dt;

    if (stateTimer >= currentStateDuration) {
      if (state == CharacterState.idle) {
        startMoving();
      } else if (reachedTarget) {
        startIdle();
      } else {
        stateTimer = 0;
      }
    }

    if (state == CharacterState.moving && !reachedTarget) {
      final Vector2 direction = targetPosition - position;
      final double distance = direction.length;

      if (distance < 5) {
        reachedTarget = true;
        if (stateTimer >= currentStateDuration) {
          startIdle();
        }
        return;
      }

      direction.normalize();
      updateDirection(direction);
      position += direction * CHARACTER_SPEED * dt;

      position
        ..x = position.x.clamp(
          size.x,
          gameRef.gameSize.x - size.x,
        )
        ..y = position.y.clamp(
          size.y,
          gameRef.gameSize.y - size.y,
        );
    }
  }
}
