import 'package:equatable/equatable.dart';

class MissileModel extends Equatable {
  final double x;
  final double y;
  final double dx;
  final double dy;
  final double speed;
  final int power;

  const MissileModel({
    this.x = 0.0,
    this.y = 0.0,
    this.dx = 0.0,
    this.dy = 0.0,
    this.speed = 3,
    this.power = 1,
  });

  MissileModel copyWith({
    double? x,
    double? y,
    double? dx,
    double? dy,
    double? speed,
    int? power,
  }) {
    return MissileModel(
      x: (x ?? this.x),
      y: (y ?? this.y),
      dx: (dx ?? this.dx),
      dy: (dy ?? this.dy),
      speed: speed ?? this.speed,
      power: power ?? this.power,
    );
  }

  @override
  List<Object?> get props => [
        x,
        y,
        dx,
        dy,
        speed,
        power,
      ];
}
