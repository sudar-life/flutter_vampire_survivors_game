import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';
import 'package:vampire_survivors_game/src/components/gui/item_select_ui.dart';
import 'package:vampire_survivors_game/src/components/gui/xp_bar.dart';
import 'package:vampire_survivors_game/src/components/timer.dart';
import 'package:vampire_survivors_game/src/cubit/game_manager.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';
import 'package:vampire_survivors_game/src/cubit/timer_manager.dart';
import 'package:vampire_survivors_game/src/enum/game_type.dart';
import 'package:vampire_survivors_game/src/model/inventory_model.dart';

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
          child: const Text('게임시작'),
        ),
      );
    }
    if (state.gameType == GameType.pause) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<GameManager>().gameResume();
          },
          child: const Text('플레이'),
        ),
      );
    }
    if (state.gameType == GameType.end) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppFont('Game Over', color: Colors.red, size: 70),
            ElevatedButton(
              onPressed: () {
                context.read<GameManager>().gameRestart();
              },
              child: const Text('재시작'),
            ),
          ],
        ),
      );
    }
    if (state.gameType == GameType.selectItem) {
      return ItemSelectUi();
    }
    return Stack(
      children: [
        BlocSelector<PlayerManager, PlayerState, Inventory>(
          selector: (PlayerState state) {
            return state.inventory;
          },
          builder: (context, state) {
            return Positioned(
                top: 40,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppFont(
                      '이동속도 : ${state.moveSpeedItem.totalValue}%',
                      color: Colors.black,
                      size: 14,
                    ),
                    AppFont(
                      '공격속도 : ${state.attackSpeedItem.totalValue}%',
                      color: Colors.black,
                      size: 14,
                    ),
                    AppFont(
                      '공격력 : ${state.powerItem.totalValue}%',
                      color: Colors.black,
                      size: 14,
                    ),
                    AppFont(
                      '행운 : ${state.luckItem.totalValue}%',
                      color: Colors.black,
                      size: 14,
                    ),
                    AppFont(
                      '회피율 : ${state.evasionItem.totalValue}%',
                      color: Colors.black,
                      size: 14,
                    ),
                    AppFont(
                      '최대체력 : ${state.maxHpItem.totalValue}%',
                      color: Colors.black,
                      size: 14,
                    ),
                    AppFont(
                      '공격범위 : ${state.attackAreaItem.totalValue}',
                      color: Colors.black,
                      size: 14,
                    ),
                  ],
                ));
          },
        ),
        Positioned(
          top: 15,
          left: 15,
          right: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              XpBar(),
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
                      BlocListener<TimerManater, TimerState>(
                        listener: (context, state) {
                          if (state.state == TimeStateType.end) {
                            context.read<GameManager>().nextStage();
                            context.read<TimerManater>().startTime(context
                                .read<GameManager>()
                                .state
                                .stage
                                .runningTime
                                .toInt());
                          }
                        },
                        child: const TimerWidget(),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
