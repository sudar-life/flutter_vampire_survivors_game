import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/components/missile.dart';
import 'package:vampire_survivors_game/src/enum/enemy_state_type.dart';
import 'package:vampire_survivors_game/src/model/enemy_model.dart';
import 'package:vampire_survivors_game/src/model/missile_model.dart';
import 'package:vampire_survivors_game/src/utils/data_util.dart';

class EnemyManager extends Cubit<EnemyState> {
  EnemyManager() : super(const EnemyState());

  canCreatedCheck(
    double backgroundWidth,
    double backgroundHeight,
    double gapTime,
    double enemyCount,
  ) {
    if (state.lastCreatedTime == null) {
      create(backgroundWidth, backgroundHeight, enemyCount.toInt());
    } else {
      var now = DateTime.now();
      if (now.difference(state.lastCreatedTime!).inSeconds > gapTime) {
        create(backgroundWidth, backgroundHeight, enemyCount.toInt());
      }
    }
  }

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
      createdTime: DateTime.now(),
    );
    emit(state.copyWith(
      lastCreatedTime: DateTime.now(),
      enemies: [...state.enemies, enemy],
    ));
  }

  moveEnemy(double targetx, double targety) {
    var newEnemies = state.enemies.map((enemy) {
      if (enemy.state == EnemyStateType.READY && enemy.createdTime != null) {
        if (enemy.createdTime!
            .isBefore(DateTime.now().subtract(const Duration(seconds: 2)))) {
          return enemy.copyWith(state: EnemyStateType.ATTACK);
        }
        return enemy;
      }
      var x = enemy.x;
      var y = enemy.y;
      var dx = targetx - x;
      var dy = targety - y;
      var distance = sqrt(dx * dx + dy * dy);
      var vx = dx / distance;
      var vy = dy / distance;
      if (enemy.isHit && enemy.knockbackPower != null) {
        // 넉백 반대 방향으로 밀어내기 (여기서는 반대 방향으로 -vx, -vy 사용)
        var knockbackDistance = enemy.knockbackPower!; // 넉백 강도
        var knockbackX = x - vx * knockbackDistance;
        var knockbackY = y - vy * knockbackDistance;

        // 새로운 위치로 적 복사
        return enemy.copyWith(x: knockbackX, y: knockbackY);
      }
      return enemy.copyWith(x: x + vx * enemy.speed, y: y + vy * enemy.speed);
    });
    emit(state.copyWith(enemies: [...newEnemies]));
  }

  checkDamage(List<MissileModel?> missiles) {
    var newEnemies = state.enemies.map((enemy) {
      var x = enemy.tx + 15;
      var y = enemy.ty + 15;
      var radius = 15.0;
      double? missilePower;
      var isHit = missiles.any((missile) {
        if (missile == null) return false;
        var centerA = Offset(x, y);
        var centerB = Offset(missile.x, missile.y);
        var radiusA = radius;
        var radiusB = 5.0;
        var isHit = GameDataUtil.isCircleColliding(
          centerA,
          radiusA,
          centerB,
          radiusB,
        );
        if (isHit) {
          missilePower = missile.power;
        }
        return isHit;
      });
      return enemy.copyWith(
        isHit: isHit,
        knockbackPower: missilePower,
      );
    });
    emit(state.copyWith(enemies: [...newEnemies]));
  }
}

class EnemyState extends Equatable {
  final List<EnemyModel> enemies;
  final DateTime? lastCreatedTime;
  const EnemyState({
    this.enemies = const [],
    this.lastCreatedTime,
  });

  EnemyState copyWith({List<EnemyModel>? enemies, DateTime? lastCreatedTime}) {
    return EnemyState(
      enemies: enemies ?? this.enemies,
      lastCreatedTime: lastCreatedTime ?? this.lastCreatedTime,
    );
  }

  @override
  List<Object?> get props => [
        enemies,
        lastCreatedTime,
      ];
}
