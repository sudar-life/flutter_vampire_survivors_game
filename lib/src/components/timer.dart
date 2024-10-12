import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';
import 'package:vampire_survivors_game/src/cubit/timer_manager.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<TimerManater>().state;
    var time = state.time;
    return AppFont(
      time < 10 ? '0$time' : time.toString(),
      color: time < 10 ? Colors.red : Colors.black,
      size: 25,
      fontWeight: FontWeight.bold,
      textAlign: TextAlign.center,
    );
  }
}
