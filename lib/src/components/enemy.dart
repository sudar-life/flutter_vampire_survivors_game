import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/cubit/enemy_manager.dart';

class Enemy extends StatelessWidget {
  final double backgroundHeight;
  final double backgroundWidth;
  const Enemy(
      {super.key,
      required this.backgroundHeight,
      required this.backgroundWidth});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<EnemyManager>();
    var state = cubit.state;
    return Positioned(
      left: backgroundWidth / 2 - 15 + state.x,
      top: backgroundHeight / 2 - 15 + state.y,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
