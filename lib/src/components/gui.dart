import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/cubit/game_manager.dart';
import 'package:vampire_survivors_game/src/enum/game_type.dart';

class Gui extends StatelessWidget {
  const Gui({super.key});

  @override
  Widget build(BuildContext context) {
    var gameManager = context.watch<GameManager>();
    var state = gameManager.state;
    if (state.gameType == GameType.idle) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<GameManager>().gameStart();
          },
          child: const Text('Start'),
        ),
      );
    }
    if (state.gameType == GameType.pause) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<GameManager>().gameResume();
          },
          child: const Text('Resume'),
        ),
      );
    }
    return Container();
  }
}
