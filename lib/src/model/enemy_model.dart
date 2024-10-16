import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/cubit/enemy_manager.dart';
import 'package:vampire_survivors_game/src/enum/enemy_state_type.dart';

class EnemyModel extends Equatable {
  final String id;
  final double areaWidth;
  final double areaHeight;
  final double x;
  final double y;
  final double speed;
  final double hp;
  final double xp;
  final double power;
  final double? knockbackPower;
  final double defense;
  final bool isHit;
  final EnemyStateType state;
  final DateTime? createdTime;
  final double? getDamaged;
  final double? damagedX;
  final double? damagedY;
  final bool? useDropItemWithXp;

  const EnemyModel({
    required this.id,
    this.areaWidth = 0.0,
    this.areaHeight = 0.0,
    this.x = 0.0,
    this.y = 0.0,
    this.speed = 3,
    this.hp = 10,
    this.xp = 10,
    this.power = 0.5,
    this.defense = 1,
    this.knockbackPower,
    this.isHit = false,
    this.state = EnemyStateType.READY,
    this.createdTime,
    this.getDamaged,
    this.damagedX,
    this.damagedY,
    this.useDropItemWithXp = false,
  });

  double get tx => areaWidth / 2 - 15 + x;
  double get ty => areaHeight / 2 - 15 + y;
  double get damageXP => areaWidth / 2 - 15 + (damagedX ?? x);
  double get damageYP => areaHeight / 2 - 15 + (damagedY ?? y);

  EnemyModel copyWith({
    String? id,
    double? areaWidth,
    double? areaHeight,
    double? x,
    double? y,
    double? speed,
    double? hp,
    double? xp,
    double? power,
    double? knockbackPower,
    double? defense,
    bool? isHit,
    EnemyStateType? state,
    DateTime? createdTime,
    double? getDamaged,
    double? damagedX,
    double? damagedY,
    bool? useDropItemWithXp,
  }) {
    return EnemyModel(
      id: (id ?? this.id),
      areaWidth: areaWidth ?? this.areaWidth,
      areaHeight: areaHeight ?? this.areaHeight,
      x: (x ?? this.x),
      y: (y ?? this.y),
      speed: speed ?? this.speed,
      hp: hp ?? this.hp,
      xp: xp ?? this.xp,
      power: power ?? this.power,
      defense: defense ?? this.defense,
      knockbackPower: knockbackPower ?? this.knockbackPower,
      isHit: isHit ?? this.isHit,
      state: state ?? this.state,
      createdTime: createdTime ?? this.createdTime,
      getDamaged: getDamaged ?? this.getDamaged,
      damagedX: damagedX ?? this.damagedX,
      damagedY: damagedY ?? this.damagedY,
      useDropItemWithXp: useDropItemWithXp ?? this.useDropItemWithXp,
    );
  }

  @override
  List<Object?> get props => [
        id,
        areaWidth,
        areaHeight,
        x,
        y,
        speed,
        hp,
        xp,
        power,
        defense,
        knockbackPower,
        state,
        isHit,
        createdTime,
        getDamaged,
        damagedX,
        useDropItemWithXp,
      ];
}
