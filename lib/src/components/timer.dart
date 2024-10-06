import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';

class TimerWidget extends StatefulWidget {
  final double initTime;
  final Function() isOverTime;
  const TimerWidget({
    super.key,
    required this.initTime,
    required this.isOverTime,
  });

  @override
  State<TimerWidget> createState() => _TimerState();
}

class _TimerState extends State<TimerWidget> {
  late double time;

  @override
  void initState() {
    super.initState();
    time = widget.initTime;
    timeRun();
  }

  timeRun() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (time > 0) {
        setState(() {
          time -= 1;
        });
      } else {
        timer.cancel();
        widget.isOverTime();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initTime != widget.initTime) {
      setState(() {
        time = widget.initTime;
        timeRun();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppFont(
      time < 10 ? '0$time' : time.toString(),
      color: time < 10 ? Colors.red : Colors.black,
      size: 25,
      fontWeight: FontWeight.bold,
      textAlign: TextAlign.center,
    );
  }
}
