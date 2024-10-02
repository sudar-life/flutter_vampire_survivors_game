import 'package:equatable/equatable.dart';

class MissileModel extends Equatable {
  final double x;
  final double y;
  final double angle;
  final double speed;
  final int power;

  const MissileModel({
    this.x = 0.0,
    this.y = 0.0,
    this.angle = 0.0,
    this.speed = 3,
    this.power = 1,
  });

  MissileModel copyWith({
    double? x,
    double? y,
    double? angle,
    double? speed,
    int? power,
  }) {
    return MissileModel(
      x: (x ?? this.x),
      y: (y ?? this.y),
      angle: (angle ?? this.angle),
      speed: speed ?? this.speed,
      power: power ?? this.power,
    );
  }

  @override
  List<Object?> get props => [
        x,
        y,
        angle,
        speed,
        power,
      ];
}
