import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/model/enemy_model.dart';
import 'package:vampire_survivors_game/src/model/player_model.dart';
import 'package:vampire_survivors_game/src/utils/data_util.dart';

class PlayerManager extends Cubit<PlayerState> {
  PlayerManager() : super(const PlayerState());

  initDirection() {
    emit(state.copyWith(directionX: 0.0, directionY: 0.0));
  }

  initPlayer() {
    emit(const PlayerState());
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
    var enemyPower = 0.0;
    var isHit = enemies.any((enemy) {
      var centerA = Offset(playerX + 20, playerY + 20);
      var centerB = Offset(enemy.x + 15, enemy.y + 15);
      var radiusA = 20.0;
      var radiusB = 15.0;
      var isHit =
          GameDataUtil.isCircleColliding(centerA, radiusA, centerB, radiusB);
      if (isHit) {
        enemyPower = enemy.power * 2;
      }
      return isHit;
    });
    Offset? targetEnemyPosition;
    var isShotPossible = enemies.any((enemy) {
      var centerA = Offset(playerX + 20, playerY + 20);
      var centerB = Offset(enemy.x + 15, enemy.y + 15);
      var radiusA = state.playerModel.attackBoundaryRadius;
      var radiusB = 15.0;
      var isPossibleShot =
          GameDataUtil.isCircleColliding(centerA, radiusA, centerB, radiusB);
      if (isPossibleShot) {
        targetEnemyPosition = Offset(enemy.tx + 15, enemy.ty + 15);
      }
      return isPossibleShot;
    });
    var currentHp = state.playerModel.hp - enemyPower;
    if (currentHp < 0) {
      currentHp = 0;
    }
    emit(state.copyWith(
      isHit: isHit,
      playerModel: state.playerModel.copyWith(hp: currentHp),
      isDead: currentHp == 0,
      isShotPossible: isShotPossible,
      targetEnemyPosition: targetEnemyPosition,
    ));
  }

  updatedShotMissileTime() {
    emit(state.copyWith(lastMissileShotTime: DateTime.now()));
  }
}

class PlayerState extends Equatable {
  final double directionX;
  final double directionY;
  final double playerMoveX;
  final double playerMoveY;
  final bool isHit;
  final bool isShotPossible;
  final PlayerModel playerModel;
  final DateTime? lastMissileShotTime;
  final Offset? targetEnemyPosition;
  final bool isDead;

  const PlayerState({
    this.directionX = 0.0,
    this.directionY = 0.0,
    this.playerMoveX = 0.0,
    this.playerMoveY = 0.0,
    this.isDead = false,
    this.playerModel = const PlayerModel(
      hp: 100,
      maxHp: 100,
      attackSpeed: 1000,
      moveSpeed: 1,
      attackBoundaryRadius: 150,
    ),
    this.isHit = false,
    this.isShotPossible = false,
    this.targetEnemyPosition,
    this.lastMissileShotTime,
  });

  PlayerState copyWith({
    double? directionX,
    double? directionY,
    double? playerMoveX,
    double? playerMoveY,
    PlayerModel? playerModel,
    bool? isHit,
    bool? isDead,
    bool? isShotPossible,
    DateTime? lastMissileShotTime,
    Offset? targetEnemyPosition,
  }) {
    return PlayerState(
      directionX: directionX ?? this.directionX,
      directionY: directionY ?? this.directionY,
      playerMoveX: playerMoveX ?? this.playerMoveX,
      playerMoveY: playerMoveY ?? this.playerMoveY,
      playerModel: playerModel ?? this.playerModel,
      isHit: isHit ?? this.isHit,
      isDead: isDead ?? this.isDead,
      isShotPossible: isShotPossible ?? this.isShotPossible,
      lastMissileShotTime: lastMissileShotTime ?? this.lastMissileShotTime,
      targetEnemyPosition: targetEnemyPosition ?? this.targetEnemyPosition,
    );
  }

  @override
  List<Object?> get props => [
        directionX,
        directionY,
        playerMoveX,
        playerMoveY,
        playerModel,
        isHit,
        isDead,
        isShotPossible,
        lastMissileShotTime,
        targetEnemyPosition,
      ];
}
