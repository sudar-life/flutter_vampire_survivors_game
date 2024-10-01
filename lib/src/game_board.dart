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
import 'package:vampire_survivors_game/src/cubit/player_movement_manager.dart';
import 'package:vampire_survivors_game/src/enum/game_type.dart';

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

    Timer.periodic(const Duration(milliseconds: 33), (timer) {
      if (context.read<GameManager>().state.gameType == GameType.start ||
          context.read<GameManager>().state.gameType == GameType.resume) {
        _moveBackground();
        _movePlayer();
        _moveEnemy();
        _moveMissile();
        _updateDirection();
      }
    });
  }

  void _moveBackground() {
    context.read<BackboardManager>().moveBackground(
          directionX: context.read<PlayerMovementManager>().state.directionX,
          directionY: context.read<PlayerMovementManager>().state.directionY,
          playerMoveX: context.read<PlayerMovementManager>().state.playerMoveX,
          playerMoveY: context.read<PlayerMovementManager>().state.playerMoveY,
          speed: speed,
        );
  }

  void _movePlayer() {
    var gameZoneWidth = context.read<BackboardManager>().state.gameZoneWidth;
    var gameZoneHeight = context.read<BackboardManager>().state.gameZoneHeight;
    context
        .read<PlayerMovementManager>()
        .movePlayer(speed, gameZoneWidth, gameZoneHeight);
  }

  void _moveEnemy() {
    var playerX = context.read<PlayerMovementManager>().state.playerMoveX;
    var playerY = context.read<PlayerMovementManager>().state.playerMoveY;
    context.read<EnemyManager>().moveEnemy(playerX, playerY);
  }

  void _moveMissile() {
    context.read<MissileManager>().moveMissile();
  }

  void _updateDirection() {
    context.read<PlayerMovementManager>().initDirection();

    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
      context.read<PlayerMovementManager>().updateDirection(directionY: 1);
    }
    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
      context.read<PlayerMovementManager>().updateDirection(directionY: -1);
    }
    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
      context.read<PlayerMovementManager>().updateDirection(directionX: 1);
    }
    if (keyManager.state.pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
      context.read<PlayerMovementManager>().updateDirection(directionX: -1);
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
                var width =
                    context.read<BackboardManager>().state.gameZoneWidth * 2;
                var height =
                    context.read<BackboardManager>().state.gameZoneHeight * 2;
                context.read<EnemyManager>().create(width, height, 3);
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
                if (event.logicalKey == LogicalKeyboardKey.space &&
                    event is KeyDownEvent) {
                  context.read<MissileManager>().shotMissile(
                      backgroundWidth,
                      backgroundHeight,
                      context.read<PlayerMovementManager>().state.playerMoveX,
                      context.read<PlayerMovementManager>().state.playerMoveY,
                      context.read<EnemyManager>().state.enemies.first.tx,
                      context.read<EnemyManager>().state.enemies.first.ty);
                }
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
