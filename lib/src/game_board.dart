import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/background_board.dart';
import 'package:vampire_survivors_game/src/components/background_decoration.dart';
import 'package:vampire_survivors_game/src/components/damage_effect.dart';
import 'package:vampire_survivors_game/src/components/enemy.dart';
import 'package:vampire_survivors_game/src/components/field_item.dart';
import 'package:vampire_survivors_game/src/components/gui.dart';
import 'package:vampire_survivors_game/src/components/missile.dart';
import 'package:vampire_survivors_game/src/components/player.dart';
import 'package:vampire_survivors_game/src/cubit/backboard_manager.dart';
import 'package:vampire_survivors_game/src/cubit/damage_effect_manager.dart';
import 'package:vampire_survivors_game/src/cubit/enemy_manager.dart';
import 'package:vampire_survivors_game/src/cubit/field_item_manager.dart';
import 'package:vampire_survivors_game/src/cubit/game_manager.dart';
import 'package:vampire_survivors_game/src/cubit/key_event_manager.dart';
import 'package:vampire_survivors_game/src/cubit/levelup_item_manager.dart';
import 'package:vampire_survivors_game/src/cubit/missile_manager.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';
import 'package:vampire_survivors_game/src/cubit/timer_manager.dart';
import 'package:vampire_survivors_game/src/enum/enemy_state_type.dart';
import 'package:vampire_survivors_game/src/enum/field_item_type.dart';
import 'package:vampire_survivors_game/src/enum/game_type.dart';
import 'package:vampire_survivors_game/src/enum/gun_sector_type.dart';
import 'package:vampire_survivors_game/src/enum/gun_type.dart';
import 'package:vampire_survivors_game/src/model/damage_info_model.dart';
import 'package:vampire_survivors_game/src/model/field_item_model.dart';
import 'package:vampire_survivors_game/src/model/gun_item_model.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late KeyEventManagerCubit keyManager;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (context.read<GameManager>().state.gameType == GameType.start ||
          context.read<GameManager>().state.gameType == GameType.resume ||
          context.read<GameManager>().state.gameType == GameType.restart) {
        _updateGame();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlayerManager>().getTheGun(GunItem(
          gunType: GunType.Pistal,
          gunSectorType: GunSectorType.LEFT,
          lastMissileShotTime: DateTime.now()));
    });
  }

  void _updateGame() {
    _moveBackground();
    _createEnemy();
    _movePlayer();
    _moveEnemy();
    _moveMissile();
    _handleCollision();
    _updateDirection();
    _shotMissile();
    _removeDamageEffect();
  }

  void _removeDamageEffect() {
    context.read<DamageEffectManager>().removeDamageEffect();
  }

  void _shotMissile() {
    var playerState = context.read<PlayerManager>().state;
    if (playerState.isShotPossible) {
      var gunItems = playerState.gunItems;
      gunItems!.forEach((key, value) {
        if (value != null &&
            DateTime.now()
                    .difference(value.lastMissileShotTime!)
                    .inMilliseconds >
                playerState.playerModel.attackSpeed * value.gunType.fireRate) {
          context.read<MissileManager>().shotMissile(
                context.read<BackboardManager>().state.gameZoneWidth * 2,
                context.read<BackboardManager>().state.gameZoneHeight * 2,
                playerState.playerMoveX,
                playerState.playerMoveY,
                playerState.targetEnemyPosition!.dx,
                playerState.targetEnemyPosition!.dy,
                value.gunSectorType,
                value.gunType,
                playerState.playerModel.powerRate,
              );
          context.read<PlayerManager>().updatedShotMissileTime(value);
        }
      });
    }
  }

  void _handleCollision() {
    //미사일 충돌감지
    context
        .read<EnemyManager>()
        .checkDamage(context.read<MissileManager>().state.missiles);
    // //적군 미사일 충돌감지
    var enemies = context
        .read<EnemyManager>()
        .state
        .enemies
        .where((element) => element.state == EnemyStateType.ATTACK)
        .toList();
    context.read<MissileManager>().checkColliding(enemies);

    // //플레이어 충돌 감지
    context.read<PlayerManager>().checkColliding(
        context.read<BackboardManager>().state.gameZoneWidth,
        context.read<BackboardManager>().state.gameZoneHeight,
        enemies);

    // // field item 충돌 감지
    var playerX = context.read<PlayerManager>().state.playerMoveX;
    var playerY = context.read<PlayerManager>().state.playerMoveY;
    context.read<FieldItemManager>().checkColliding(playerX, playerY, 10);
  }

  void _moveBackground() {
    var playerState = context.read<PlayerManager>().state;
    context.read<BackboardManager>().moveBackground(
          directionX: playerState.directionX,
          directionY: playerState.directionY,
          playerMoveX: playerState.playerMoveX,
          playerMoveY: playerState.playerMoveY,
          speed: playerState.playerModel.moveSpeed,
        );
  }

  void _movePlayer() {
    var gameZoneWidth = context.read<BackboardManager>().state.gameZoneWidth;
    var gameZoneHeight = context.read<BackboardManager>().state.gameZoneHeight;
    context.read<PlayerManager>().movePlayer(gameZoneWidth, gameZoneHeight);
  }

  void _createEnemy() {
    var gameState = context.read<GameManager>().state;
    if (gameState.gameType != GameType.start &&
        gameState.gameType != GameType.restart &&
        gameState.gameType != GameType.resume) {
      return;
    }
    var currentStage = gameState.stage;
    var gapTime = currentStage.responeGapTime;
    var oneTimeHowMany = currentStage.oneTimeEnemySpotCounts;

    var width = context.read<BackboardManager>().state.gameZoneWidth * 2;
    var height = context.read<BackboardManager>().state.gameZoneHeight * 2;
    context.read<EnemyManager>().canCreatedCheck(
          width,
          height,
          gapTime,
          oneTimeHowMany,
          currentStage.stagePerEnemyTypes,
        );
  }

  void _moveEnemy() {
    var playerX = context.read<PlayerManager>().state.playerMoveX;
    var playerY = context.read<PlayerManager>().state.playerMoveY;
    context.read<EnemyManager>().moveEnemy(playerX, playerY);
  }

  void _moveMissile() {
    context.read<MissileManager>().moveMissile();
  }

  void _updateDirection() {
    context.read<PlayerManager>().initDirection();

    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
      context.read<PlayerManager>().updateDirection(directionY: 1);
    }
    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
      context.read<PlayerManager>().updateDirection(directionY: -1);
    }
    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
      context.read<PlayerManager>().updateDirection(directionX: 1);
    }
    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
      context.read<PlayerManager>().updateDirection(directionX: -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    keyManager = context.read<KeyEventManagerCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<FieldItemManager, FieldItemState>(
          listenWhen: (previous, current) =>
              previous.getItems.length != current.getItems.length,
          listener: (context, state) {
            context.read<PlayerManager>().getItems(state.getItems.toList(),
                context.read<GameManager>().state.stage);
            context.read<FieldItemManager>().clearGetItems();
          },
        ),
        BlocListener<EnemyManager, EnemyState>(listenWhen: (previous, current) {
          return previous.deadEnemies.length != current.deadEnemies.length;
        }, listener: (context, state) {
          state.deadEnemies.where((d) {
            var xpItem = FieldItemModel(
              areaWidth: d.areaWidth,
              areaHeight: d.areaHeight,
              type: FieldItemType.XP,
              value: d.xp,
              x: d.x,
              y: d.y,
            );
            context.read<FieldItemManager>().addFieldItem(xpItem);
            return false;
          }).toList();
        }),
        BlocListener<EnemyManager, EnemyState>(
          listenWhen: (previous, current) =>
              previous.damagedPoints.length != current.damagedPoints.length,
          listener: (context, state) {
            state.damagedPoints.where((d) {
              if (!d.isExpired()) {
                context.read<DamageEffectManager>().addDamage(d);
              }
              return false;
            }).toList();
          },
        ),
        BlocListener<PlayerManager, PlayerState>(
          listenWhen: (previous, current) =>
              previous.damagedPoints.length != current.damagedPoints.length,
          listener: (context, state) {
            state.damagedPoints.where((d) {
              if (!d.isExpired()) {
                context.read<DamageEffectManager>().addDamage(d);
              }
              return false;
            }).toList();
          },
        ),
        BlocListener<PlayerManager, PlayerState>(listener: (context, state) {
          if (state.isDead) {
            context.read<GameManager>().gameEnd();
          }
          if (state.playerModel.level > 1 && state.playerModel.xp == 0) {
            context
                .read<LevelUpItemManager>()
                .makeRandomItems(state.playerModel.luckPercent);
            context.read<GameManager>().selectItemMode();
            context.read<PlayerManager>().getItems([
              const FieldItemModel(
                  type: FieldItemType.XP, value: 0.001, x: 0, y: 0),
            ], context.read<GameManager>().state.stage);
          }
        }),
        BlocListener<GameManager, GameState>(
          listener: (context, state) {
            switch (state.gameType) {
              case GameType.start:
                context
                    .read<TimerManater>()
                    .startTime(state.stage.runningTime.toInt());
                break;
              case GameType.pause:
                context.read<TimerManater>().pauseTime();
                break;
              case GameType.resume:
                context.read<TimerManater>().resumeTime();
                break;
              case GameType.end:
                break;
              case GameType.idle:
                break;
              case GameType.restart:
                context.read<PlayerManager>().initPlayer();
                context.read<EnemyManager>().initEnemy();
                context.read<BackboardManager>().init();
                context.read<MissileManager>().init();
                context.read<DamageEffectManager>().clear();
                context.read<GameManager>().gameStart();
                break;
              case GameType.selectItem:
                context.read<TimerManater>().pauseTime();
                break;
            }
          },
        ),
      ],
      child: LayoutBuilder(builder: (context, constrant) {
        context
            .read<BackboardManager>()
            .updateGameZoneSize(constrant.maxWidth, constrant.maxHeight);
        var backgroundWidth = constrant.maxWidth * 2;
        var backgroundHeight = constrant.maxHeight * 2;
        return Material(
          color: const Color.fromARGB(255, 77, 77, 77),
          child: SafeArea(
            child: Focus(
              autofocus: true,
              onKeyEvent: (node, event) {
                if (event.logicalKey == LogicalKeyboardKey.escape) {
                  context.read<GameManager>().gamePause();
                }
                if (event is KeyDownEvent || event is KeyRepeatEvent) {
                  keyManager.addKey(event.logicalKey);
                } else if (event is KeyUpEvent) {
                  keyManager.removeKey(event.logicalKey);
                }
                return KeyEventResult.handled;
              },
              child: BackgroundBoard(
                backgroundWidth: backgroundWidth,
                backgroundHeight: backgroundHeight,
                gui: const Gui(),
                children: [
                  BackgroundDecoration(
                    areaWidth: backgroundWidth,
                    areaHeight: backgroundHeight,
                  ),
                  Player(
                    backgroundHeight: backgroundHeight,
                    backgroundWidth: backgroundWidth,
                  ),
                  BlocBuilder<MissileManager, MissileState>(
                      builder: (context, state) {
                    return Stack(
                      children: state.missiles
                          .where((element) => element != null)
                          .map((missile) => Missile(
                                x: missile!.x,
                                y: missile.y,
                                gunType: missile.gunType!,
                              ))
                          .toList(),
                    );
                  }),
                  BlocBuilder<EnemyManager, EnemyState>(
                      builder: (context, state) {
                    return Stack(
                      children: state.enemies
                          .map((enemy) => Enemy(
                                x: enemy.tx,
                                y: enemy.ty,
                                isHit: enemy.isHit,
                                type: enemy.state,
                              ))
                          .toList(),
                    );
                  }),
                  BlocBuilder<FieldItemManager, FieldItemState>(
                      builder: (context, state) {
                    return Stack(
                      children: state.fieldItems
                          .map((item) => FieldItem(
                                x: item.tx,
                                y: item.ty,
                                type: item.type,
                              ))
                          .toList(),
                    );
                  }),
                  BlocBuilder<DamageEffectManager, DamageEffectState>(
                      builder: (context, state) {
                    return Stack(
                      children: state.damagedPoints
                          .map((damage) => DamageEffect(
                                x: damage.x,
                                y: damage.y,
                                damage: damage.damage,
                                isMiss: damage.isMiss,
                                color: damage.targetType == TargetType.PLAYER
                                    ? Colors.red
                                    : Colors.black,
                              ))
                          .toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
