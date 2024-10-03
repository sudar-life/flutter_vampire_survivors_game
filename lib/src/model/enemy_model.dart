import 'dart:ui';

import 'package:equatable/equatable.dart';

class EnemyModel extends Equatable {
  final double areaWidth;
  final double areaHeight;
  final double x;
  final double y;
  final double speed;
  final int hp;
  final double power;
  final double? knockbackPower;
  final int defense;
  final bool isHit;

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
  });

  double get tx => areaWidth / 2 - 15 + x;
  double get ty => areaHeight / 2 - 15 + y;

  EnemyModel copyWith({
    double? areaWidth,
    double? areaHeight,
    double? x,
    double? y,
    double? speed,
    int? hp,
    double? power,
    double? knockbackPower,
    int? defense,
    bool? isHit,
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
        isHit,
      ];
}
