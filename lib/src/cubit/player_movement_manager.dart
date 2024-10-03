import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/model/enemy_model.dart';
import 'package:vampire_survivors_game/src/utils/data_util.dart';

class PlayerMovementManager extends Cubit<PlayerMoveMentState> {
  PlayerMovementManager() : super(const PlayerMoveMentState());

  initDirection() {
    emit(state.copyWith(directionX: 0.0, directionY: 0.0));
  }

  updateDirection({double? directionX, double? directionY}) {
    emit(state.copyWith(
      directionX: state.directionX + (directionX ?? 0.0),
      directionY: state.directionY + (directionY ?? 0.0),
    ));
  }

  movePlayer(double speed, double gameZoneWidth, double gameZoneHeight) {
    emit(state.copyWith(
      playerMoveX: state.playerMoveX - state.directionX * speed,
      playerMoveY: state.playerMoveY - state.directionY * speed,
    ));

    if (state.playerMoveX - 15 <= gameZoneWidth * -1) {
      emit(state.copyWith(playerMoveX: gameZoneWidth * -1 + 15));
    }
    if (state.playerMoveX + 15 >= gameZoneWidth) {
      emit(state.copyWith(playerMoveX: gameZoneWidth - 15));
    }
    if (state.playerMoveY - 15 <= gameZoneHeight * -1) {
      emit(state.copyWith(playerMoveY: gameZoneHeight * -1 + 15));
    }
    if (state.playerMoveY + 15 >= gameZoneHeight) {
      emit(state.copyWith(playerMoveY: gameZoneHeight - 15));
    }
  }

  checkColliding(List<EnemyModel> enemies) {
    var playerX = state.playerMoveX;
    var playerY = state.playerMoveY;
    var isHit = enemies.any((enemy) {
      var centerA = Offset(playerX, playerY);
      var centerB = Offset(enemy.x + 15, enemy.y + 15);
      var radiusA = 15.0;
      var radiusB = 15.0;
      return GameDataUtil.isCircleColliding(centerA, radiusA, centerB, radiusB);
    });
    print(isHit);
    emit(state.copyWith(isHit: isHit));
  }
}

class PlayerMoveMentState extends Equatable {
  final double directionX;
  final double directionY;
  final double playerMoveX;
  final double playerMoveY;
  final bool isHit;

  const PlayerMoveMentState({
    this.directionX = 0.0,
    this.directionY = 0.0,
    this.playerMoveX = 0.0,
    this.playerMoveY = 0.0,
    this.isHit = false,
  });

  PlayerMoveMentState copyWith({
    double? directionX,
    double? directionY,
    double? playerMoveX,
    double? playerMoveY,
    bool? isHit,
  }) {
    return PlayerMoveMentState(
      directionX: directionX ?? this.directionX,
      directionY: directionY ?? this.directionY,
      playerMoveX: playerMoveX ?? this.playerMoveX,
      playerMoveY: playerMoveY ?? this.playerMoveY,
      isHit: isHit ?? this.isHit,
    );
  }

  @override
  List<Object?> get props => [
        directionX,
        directionY,
        playerMoveX,
        playerMoveY,
        isHit,
      ];
}
