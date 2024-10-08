import 'dart:math';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/enum/gun_sector_type.dart';
import 'package:vampire_survivors_game/src/model/enemy_model.dart';
import 'package:vampire_survivors_game/src/model/missile_model.dart';
import 'package:vampire_survivors_game/src/utils/data_util.dart';

class MissileManager extends Cubit<MissileState> {
  double? width;
  double? height;
  MissileManager() : super(const MissileState());

  shotMissile(
    double width,
    double height,
    double sx,
    double sy,
    double tx,
    double ty,
    GunSectorType gunSectorType,
  ) {
    this.width = width;
    this.height = height;
    var x = width / 2 - 15 + sx + gunSectorType.adjustPoint.dx;
    var y = height / 2 - 15 + sy + gunSectorType.adjustPoint.dy;
    var speed = 15.0;
    var missile = MissileModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      x: x,
      y: y,
      angle: atan2(((ty + 15) - y), ((tx + 15) - x)),
      speed: speed,
      power: 10,
    );
    emit(state.copyWith(missiles: [...state.missiles, missile]));
  }

  moveMissile() {
    var newMissiles =
        state.missiles.where((element) => element != null).map((missile) {
      var x = missile!.x;
      var y = missile.y;
      if (x < 0 || y < 0 || x > width! || y > height!) {
        return null;
      }
      final double currentX = x + missile.speed * cos(missile.angle);
      final double currentY = y + missile.speed * sin(missile.angle);
      return missile.copyWith(x: currentX, y: currentY);
    });
    emit(state.copyWith(missiles: [...newMissiles]));
  }

  checkColliding(List<EnemyModel> enemies) {
    var newMissiles =
        state.missiles.where((element) => element != null).toList();
    var newEnemies = enemies;
    newMissiles.removeWhere((missile) {
      if (missile == null) return false;
      var x = missile.x;
      var y = missile.y;
      var radius = 5.0;
      var isHit = newEnemies.any((enemy) {
        var centerA = Offset(x, y);
        var centerB = Offset(enemy.tx + 15, enemy.ty + 15);
        var radiusA = radius;
        var radiusB = 15.0;
        return GameDataUtil.isCircleColliding(
            centerA, radiusA, centerB, radiusB);
      });
      return isHit;
    });
    emit(state.copyWith(missiles: [...newMissiles]));
  }
}

class MissileState extends Equatable {
  final List<MissileModel?> missiles;
  const MissileState({
    this.missiles = const [],
  });

  MissileState copyWith({
    List<MissileModel?>? missiles,
  }) {
    return MissileState(
      missiles: missiles ?? this.missiles,
    );
  }

  @override
  List<Object> get props => [missiles];
}
