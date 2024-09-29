import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:vampire_survivors_game/src/components/background_decoration.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  double gameZoneWidth = 0;
  double gameZoneHeight = 0;

  double backgroundMoveX = 0;
  double backgroundMoveY = 0;

  double playerMoveX = 0;
  double playerMoveY = 0;

  double directionX = 0;
  double directionY = 0;

  //캐릭터 이동 속도
  double speed = 6;
  // 현재 눌려있는 키들을 관리하는 Set
  Set<LogicalKeyboardKey> pressedKeys = {};

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _moveBackground();
      _movePlayer();
      update();
    });
  }

  void update() => setState(() {});

  void _moveBackground() {
    if (backgroundMoveX > gameZoneWidth / 2 * 1.5) {
      backgroundMoveX = gameZoneWidth / 2 * 1.5;
    }
    if (backgroundMoveX < -gameZoneWidth / 2 * 1.5) {
      backgroundMoveX = -gameZoneWidth / 2 * 1.5;
    }

    if (backgroundMoveY > gameZoneHeight / 2 * 1.5) {
      backgroundMoveY = gameZoneHeight / 2 * 1.5;
    }
    if (backgroundMoveY < -gameZoneHeight / 2 * 1.5) {
      backgroundMoveY = -gameZoneHeight / 2 * 1.5;
    }
    if (playerMoveX > gameZoneWidth / 2 * 1.5 ||
        playerMoveX < -gameZoneWidth / 2 * 1.5) {
      if (playerMoveY > gameZoneHeight / 2 * 1.5 ||
          playerMoveY < -gameZoneHeight / 2 * 1.5) {
        return;
      } else {
        backgroundMoveY -= directionY * speed;
      }
      return;
    }
    if (playerMoveY > gameZoneHeight / 2 * 1.5 ||
        playerMoveY < -gameZoneHeight / 2 * 1.5) {
      if (playerMoveX > gameZoneWidth / 2 * 1.5 ||
          playerMoveX < -gameZoneWidth / 2 * 1.5) {
        return;
      } else {
        backgroundMoveX -= directionX * speed;
      }
      return;
    }
    backgroundMoveX -= directionX * speed;
    backgroundMoveY -= directionY * speed;
  }

  void _movePlayer() {
    playerMoveX -= directionX * speed;
    playerMoveY -= directionY * speed;

    if (playerMoveX - 15 <= gameZoneWidth * -1) {
      playerMoveX = gameZoneWidth * -1 + 15;
    }
    if (playerMoveX + 15 >= gameZoneWidth) {
      playerMoveX = gameZoneWidth - 15;
    }
    if (playerMoveY - 15 <= gameZoneHeight * -1) {
      playerMoveY = gameZoneHeight * -1 + 15;
    }
    if (playerMoveY + 15 >= gameZoneHeight) {
      playerMoveY = gameZoneHeight - 15;
    }
  }

  void moveLogic(bool isDown, LogicalKeyboardKey key) {
    switch (key) {
      case LogicalKeyboardKey.arrowUp:
        directionY = isDown ? 1 : 0;
        break;
      case LogicalKeyboardKey.arrowDown:
        directionY = isDown ? -1 : 0;
        break;
      case LogicalKeyboardKey.arrowLeft:
        directionX = isDown ? 1 : 0;
        break;
      case LogicalKeyboardKey.arrowRight:
        directionX = isDown ? -1 : 0;
        break;
    }
  }

  void _updateDirection() {
    directionX = 0;
    directionY = 0;

    if (pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
      directionY += 1;
    }
    if (pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
      directionY -= 1;
    }
    if (pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
      directionX += 1;
    }
    if (pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
      directionX -= 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrant) {
      gameZoneWidth = constrant.maxWidth;
      gameZoneHeight = constrant.maxHeight;
      var backgroundWidth = gameZoneWidth * 2;
      var backgroundHeight = gameZoneHeight * 2;
      return Material(
        color: const Color.fromARGB(255, 77, 77, 77),
        child: SafeArea(
          child: Focus(
            autofocus: true,
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent || event is KeyRepeatEvent) {
                pressedKeys.add(event.logicalKey);
              } else if (event is KeyUpEvent) {
                pressedKeys.remove(event.logicalKey);
              }
              _updateDirection();
              return KeyEventResult.handled;
            },
            child: Stack(
              children: [
                Positioned(
                  left: -gameZoneWidth / 2 + backgroundMoveX * -1,
                  top: -gameZoneHeight / 2 + backgroundMoveY * -1,
                  child: ScaleTransition(
                    scale: AlwaysStoppedAnimation(1),
                    child: Container(
                      width: backgroundWidth,
                      height: backgroundHeight,
                      color: Color(0xffB1C989),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: BackgroundDecoration(
                              areaWidth: backgroundWidth,
                              areaHeight: backgroundHeight,
                            ),
                          ),
                          Positioned(
                            left: backgroundWidth / 2 - 15 + playerMoveX,
                            top: backgroundHeight / 2 - 15 + playerMoveY,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
