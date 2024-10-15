import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/field_item_type.dart';
import 'package:vampire_survivors_game/src/model/enemy_model.dart';
import 'package:vampire_survivors_game/src/model/field_item_model.dart';
import 'package:vampire_survivors_game/src/model/inventory_model.dart';
import 'package:vampire_survivors_game/src/model/item_model.dart';
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

  movePlayer(double gameZoneWidth, double gameZoneHeight) {
    emit(state.copyWith(
      playerMoveX:
          state.playerMoveX - state.directionX * state.playerModel.moveSpeed,
      playerMoveY:
          state.playerMoveY - state.directionY * state.playerModel.moveSpeed,
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

  getItems(List<FieldItemModel> items) {
    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      switch (item.type) {
        case FieldItemType.XP:
          updateXp(item);
          break;
        case FieldItemType.HEAL:
          emit(state.copyWith(
            playerModel: state.playerModel
                .copyWith(hp: state.playerModel.hp + item.value),
          ));
          break;
      }
    }
  }

  updateXp(FieldItemModel item) {
    if (state.playerModel.xp + item.value <= state.playerModel.nextLevelXp) {
      emit(state.copyWith(
        playerModel: state.playerModel.copyWith(
          xp: state.playerModel.xp + item.value,
        ),
      ));
    } else {
      emit(state.copyWith(
        playerModel: state.playerModel.copyWith(
          xp: 0,
          level: state.playerModel.level + 1,
          nextLevelXp: state.playerModel.nextLevelXp * 2,
          hp: state.playerModel.maxHp,
        ),
      ));
    }
  }

  upgradeItem(ItemModel item) {
    var newInventory = state.inventory.addItem(item: item);
    var newPlayerModel = const PlayerModel(
      hp: 100,
      maxHp: 100,
      attackSpeed: 1000,
      moveSpeed: 5,
      attackBoundaryRadius: 100,
      xp: 0,
      nextLevelXp: 100,
    );
    newPlayerModel = newPlayerModel.upgradeState(newInventory);
    emit(state.copyWith(
      inventory: state.inventory.addItem(item: item),
      playerModel: newPlayerModel,
    ));
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
  final Inventory inventory;
  final DateTime? lastMissileShotTime;
  final Offset? targetEnemyPosition;
  final bool isDead;

  const PlayerState({
    this.directionX = 0.0,
    this.directionY = 0.0,
    this.playerMoveX = 0.0,
    this.playerMoveY = 0.0,
    this.isDead = false,
    this.inventory = const Inventory(),
    this.playerModel = const PlayerModel(
      hp: 100,
      maxHp: 100,
      attackSpeed: 1000,
      moveSpeed: 5,
      attackBoundaryRadius: 100,
      xp: 0,
      nextLevelXp: 100,
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
    Inventory? inventory,
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
      inventory: inventory ?? this.inventory,
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
        inventory,
      ];
}
