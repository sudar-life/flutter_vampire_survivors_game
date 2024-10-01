import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/cubit/player_movement_manager.dart';

class Player extends StatelessWidget {
  final double backgroundHeight;
  final double backgroundWidth;
  const Player(
      {super.key,
      required this.backgroundHeight,
      required this.backgroundWidth});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<PlayerMovementManager>();
    var state = cubit.state;
    var x = backgroundWidth / 2 - 25 + state.playerMoveX;
    var y = backgroundHeight / 2 - 25 + state.playerMoveY;
    return Positioned(
      left: x,
      top: y,
      child: Stack(
        children: [
          Container(
            width: 50,
            height: 50,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 20,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 20,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
