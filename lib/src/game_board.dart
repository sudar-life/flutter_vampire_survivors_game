import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/background_board.dart';
import 'package:vampire_survivors_game/src/components/background_decoration.dart';
import 'package:vampire_survivors_game/src/components/enemy.dart';
import 'package:vampire_survivors_game/src/components/gui.dart';
import 'package:vampire_survivors_game/src/components/missile.dart';
import 'package:vampire_survivors_game/src/components/player.dart';
import 'package:vampire_survivors_game/src/cubit/backboard_manager.dart';
import 'package:vampire_survivors_game/src/cubit/enemy_manager.dart';
import 'package:vampire_survivors_game/src/cubit/game_manager.dart';
import 'package:vampire_survivors_game/src/cubit/key_event_manager.dart';
import 'package:vampire_survivors_game/src/cubit/missile_manager.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';
import 'package:vampire_survivors_game/src/enum/enemy_state_type.dart';
import 'package:vampire_survivors_game/src/enum/game_type.dart';
import 'package:vampire_survivors_game/src/enum/gun_sector_type.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late KeyEventManagerCubit keyManager;
  double speed = 6;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (context.read<GameManager>().state.gameType == GameType.start ||
          context.read<GameManager>().state.gameType == GameType.resume) {
        _updateGame();
      }
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
  }

  void _shotMissile() {
    var playerState = context.read<PlayerManager>().state;
    if (playerState.isShotPossible) {
      var lastShotMissileTime = playerState.lastMissileShotTime;
      if ((lastShotMissileTime == null ||
              DateTime.now().difference(lastShotMissileTime).inMilliseconds >
                  playerState.playerModel.attackSpeed) &&
          playerState.targetEnemyPosition != null) {
        context.read<MissileManager>().shotMissile(
              context.read<BackboardManager>().state.gameZoneWidth * 2,
              context.read<BackboardManager>().state.gameZoneHeight * 2,
              playerState.playerMoveX,
              playerState.playerMoveY,
              playerState.targetEnemyPosition!.dx,
              playerState.targetEnemyPosition!.dy,
              GunSectorType.TOP,
            );
        context.read<PlayerManager>().updatedShotMissileTime();
      }
    }
  }

  void _handleCollision() {
    //미사일 충돌감지
    context
        .read<EnemyManager>()
        .checkDamage(context.read<MissileManager>().state.missiles);
    //적군 미사일 충돌감지
    var enemies = context
        .read<EnemyManager>()
        .state
        .enemies
        .where((element) => element.state == EnemyStateType.ATTACK)
        .toList();
    context.read<MissileManager>().checkColliding(enemies);

    //플레이어 충돌 감지
    context.read<PlayerManager>().checkColliding(enemies);
  }

  void _moveBackground() {
    context.read<BackboardManager>().moveBackground(
          directionX: context.read<PlayerManager>().state.directionX,
          directionY: context.read<PlayerManager>().state.directionY,
          playerMoveX: context.read<PlayerManager>().state.playerMoveX,
          playerMoveY: context.read<PlayerManager>().state.playerMoveY,
          speed: speed,
        );
  }

  void _movePlayer() {
    var gameZoneWidth = context.read<BackboardManager>().state.gameZoneWidth;
    var gameZoneHeight = context.read<BackboardManager>().state.gameZoneHeight;
    context
        .read<PlayerManager>()
        .movePlayer(speed, gameZoneWidth, gameZoneHeight);
  }

  void _createEnemy() {
    var gameState = context.read<GameManager>().state;
    if (gameState.gameType != GameType.start) {
      return;
    }
    var currentStage = context.read<GameManager>().state.stage;
    var gapTime = currentStage.responeGapTime;
    var oneTimeHowMany = currentStage.oneTimeEnemySpotCounts;

    var width = context.read<BackboardManager>().state.gameZoneWidth * 2;
    var height = context.read<BackboardManager>().state.gameZoneHeight * 2;
    context
        .read<EnemyManager>()
        .canCreatedCheck(width, height, gapTime, oneTimeHowMany);
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
        BlocListener<GameManager, GameState>(
          listener: (context, state) {
            switch (state.gameType) {
              case GameType.start:
                break;
              case GameType.pause:
                break;
              case GameType.resume:
                break;
              case GameType.end:
                break;
              case GameType.idle:
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
