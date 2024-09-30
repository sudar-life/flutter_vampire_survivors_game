import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/cubit/backboard_manager.dart';

class BackgroundBoard extends StatelessWidget {
  final double backgroundWidth;
  final double backgroundHeight;
  final List<Widget> children;
  final Widget gui;
  const BackgroundBoard({
    super.key,
    this.backgroundWidth = 1000,
    this.backgroundHeight = 1000,
    this.children = const [],
    required this.gui,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<BackboardManager>();
    var state = cubit.state;
    return Stack(children: [
      Positioned(
        left: -state.gameZoneWidth / 2 + state.backgroundMoveX * -1,
        top: -state.gameZoneHeight / 2 + state.backgroundMoveY * -1,
        child: ScaleTransition(
          scale: AlwaysStoppedAnimation(1),
          child: Container(
            width: backgroundWidth,
            height: backgroundHeight,
            color: const Color(0xffB1C989),
            child: Stack(children: children),
          ),
        ),
      ),
      gui,
    ]);
  }
}
