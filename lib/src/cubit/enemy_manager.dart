import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class EnemyManager extends Cubit<EnemyState> {
  EnemyManager() : super(const EnemyState());

  create(double backgroundWidth, double backgroundHeight) {
    var x = Random().nextDouble() * backgroundWidth / 2;
    var y = Random().nextDouble() * backgroundHeight / 2;
    var nx = Random().nextBool();
    var ny = Random().nextBool();
    emit(state.copyWith(x: x * (nx ? 1 : -1), y: y * (ny ? 1 : -1)));
  }

  moveEnemy(double speed, double targetx, double targety) {
    var x = state.x;
    var y = state.y;
    var dx = targetx - x;
    var dy = targety - y;
    var distance = sqrt(dx * dx + dy * dy);
    var vx = dx / distance;
    var vy = dy / distance;
    emit(state.copyWith(x: x + vx * speed, y: y + vy * speed));
  }
}

class EnemyState extends Equatable {
  final double x;
  final double y;
  const EnemyState({
    this.x = 0.0,
    this.y = 0.0,
  });

  EnemyState copyWith({
    double? x,
    double? y,
  }) {
    return EnemyState(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  @override
  List<Object?> get props => [
        x,
        y,
      ];
}
