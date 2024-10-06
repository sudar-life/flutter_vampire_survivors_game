import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';
import 'package:vampire_survivors_game/src/components/timer.dart';
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
    return Positioned(
      top: 15,
      left: 15,
      right: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white.withOpacity(0.5),
              border: Border.all(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          BlocBuilder<GameManager, GameState>(
            builder: (context, state) {
              return Column(
                children: [
                  AppFont(
                    'STAGE - ${state.stage.index}',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  TimerWidget(
                    initTime: state.stage.runningTime,
                    isOverTime: () {
                      context.read<GameManager>().nextStage();
                    },
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
