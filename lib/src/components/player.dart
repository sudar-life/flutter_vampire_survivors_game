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
    return Positioned(
      left: backgroundWidth / 2 - 15 + state.playerMoveX,
      top: backgroundHeight / 2 - 15 + state.playerMoveY,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}
