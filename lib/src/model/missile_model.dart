import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/gun_type.dart';

class MissileModel extends Equatable {
  final String id;
  final double x;
  final double y;
  final double angle;
  final double speed;
  final double power;
  final GunType? gunType;

  MissileModel({
    required this.id,
    this.x = 0.0,
    this.y = 0.0,
    this.angle = 0.0,
    this.speed = 3,
    this.power = 1,
    this.gunType,
  });

  MissileModel copyWith({
    String? id,
    double? x,
    double? y,
    double? angle,
    double? speed,
    double? power,
    GunType? gunType,
  }) {
    return MissileModel(
      id: (id ?? this.id),
      x: (x ?? this.x),
      y: (y ?? this.y),
      angle: (angle ?? this.angle),
      speed: speed ?? this.speed,
      power: power ?? this.power,
      gunType: gunType ?? this.gunType,
    );
  }

  @override
  List<Object?> get props => [
        x,
        y,
        angle,
        speed,
        power,
        gunType,
      ];
}
