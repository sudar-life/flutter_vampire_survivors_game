import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/model/enemy_model.dart';

class EnemyManager extends Cubit<EnemyState> {
  EnemyManager() : super(const EnemyState());

  create(double backgroundWidth, double backgroundHeight, int enemyCount) {
    for (var i = 0; i < enemyCount; i++) {
      _createEnemy(backgroundWidth, backgroundHeight);
    }
  }

  _createEnemy(backgroundWidth, backgroundHeight) {
    var x = Random().nextDouble() * backgroundWidth / 2;
    var y = Random().nextDouble() * backgroundHeight / 2;
    var nx = Random().nextBool();
    var ny = Random().nextBool();
    var enemy = EnemyModel(
      areaWidth: backgroundWidth,
      areaHeight: backgroundHeight,
      x: x * (nx ? 1 : -1),
      y: y * (ny ? 1 : -1),
      speed: 3,
    );
    emit(state.copyWith(enemies: [...state.enemies, enemy]));
  }

  moveEnemy(double targetx, double targety) {
    var newEnemies = state.enemies.map((enemy) {
      var x = enemy.x;
      var y = enemy.y;
      var dx = targetx - x;
      var dy = targety - y;
      var distance = sqrt(dx * dx + dy * dy);
      var vx = dx / distance;
      var vy = dy / distance;
      return enemy.copyWith(x: x + vx * enemy.speed, y: y + vy * enemy.speed);
    });
    emit(state.copyWith(enemies: [...newEnemies]));
  }
}

class EnemyState extends Equatable {
  final List<EnemyModel> enemies;
  const EnemyState({
    this.enemies = const [],
  });

  EnemyState copyWith({
    List<EnemyModel>? enemies,
  }) {
    return EnemyState(
      enemies: enemies ?? this.enemies,
    );
  }

  @override
  List<Object?> get props => [
        enemies,
      ];
}
