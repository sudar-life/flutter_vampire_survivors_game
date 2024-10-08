import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/cubit/enemy_manager.dart';
import 'package:vampire_survivors_game/src/enum/enemy_state_type.dart';

class EnemyModel extends Equatable {
  final double areaWidth;
  final double areaHeight;
  final double x;
  final double y;
  final double speed;
  final double hp;
  final double power;
  final double? knockbackPower;
  final double defense;
  final bool isHit;
  final EnemyStateType state;
  final DateTime? createdTime;
  final double? getDamaged;
  final double? damagedX;
  final double? damagedY;

  const EnemyModel({
    this.areaWidth = 0.0,
    this.areaHeight = 0.0,
    this.x = 0.0,
    this.y = 0.0,
    this.speed = 3,
    this.hp = 10,
    this.power = 0.5,
    this.defense = 1,
    this.knockbackPower,
    this.isHit = false,
    this.state = EnemyStateType.READY,
    this.createdTime,
    this.getDamaged,
    this.damagedX,
    this.damagedY,
  });

  double get tx => areaWidth / 2 - 15 + x;
  double get ty => areaHeight / 2 - 15 + y;
  double get damageXP => areaWidth / 2 - 15 + (damagedX ?? x);
  double get damageYP => areaHeight / 2 - 15 + (damagedY ?? y);

  EnemyModel copyWith({
    double? areaWidth,
    double? areaHeight,
    double? x,
    double? y,
    double? speed,
    double? hp,
    double? power,
    double? knockbackPower,
    double? defense,
    bool? isHit,
    EnemyStateType? state,
    DateTime? createdTime,
    double? getDamaged,
    double? damagedX,
    double? damagedY,
  }) {
    return EnemyModel(
      areaWidth: areaWidth ?? this.areaWidth,
      areaHeight: areaHeight ?? this.areaHeight,
      x: (x ?? this.x),
      y: (y ?? this.y),
      speed: speed ?? this.speed,
      hp: hp ?? this.hp,
      power: power ?? this.power,
      defense: defense ?? this.defense,
      knockbackPower: knockbackPower ?? this.knockbackPower,
      isHit: isHit ?? this.isHit,
      state: state ?? this.state,
      createdTime: createdTime ?? this.createdTime,
      getDamaged: getDamaged ?? this.getDamaged,
      damagedX: damagedX ?? this.damagedX,
      damagedY: damagedY ?? this.damagedY,
    );
  }

  @override
  List<Object?> get props => [
        areaWidth,
        areaHeight,
        x,
        y,
        speed,
        hp,
        power,
        defense,
        knockbackPower,
        state,
        isHit,
        createdTime,
        getDamaged,
        damagedX,
      ];
}
