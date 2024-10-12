import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class TimerManater extends Cubit<TimerState> {
  TimerManater() : super(const TimerState()) {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (state.state == TimeStateType.start) {
        updateTime();
      }
    });
  }

  void startTime(int initTime) {
    emit(
      state.copyWith(
        time: initTime,
        state: TimeStateType.start,
      ),
    );
  }

  void pauseTime() {
    emit(state.copyWith(state: TimeStateType.pause));
  }

  void resumeTime() {
    emit(state.copyWith(state: TimeStateType.start));
  }

  updateTime() {
    var time = state.time - 1;
    emit(state.copyWith(
        time: time < 0 ? 0 : time,
        state: time == 0 ? TimeStateType.end : state.state));
  }
}

enum TimeStateType {
  idle,
  start,
  end,
  pause,
}

class TimerState extends Equatable {
  final int time;
  final TimeStateType state;
  const TimerState({
    this.time = 0,
    this.state = TimeStateType.idle,
  });

  TimerState copyWith({
    int? time,
    TimeStateType? state,
  }) {
    return TimerState(
      time: time ?? this.time,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [
        time,
        state,
      ];
}
