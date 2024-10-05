import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final double hp;
  final double attackBoundaryRadius;
  final double attackSpeed;
  final double moveSpeed;

  const PlayerModel({
    required this.hp,
    required this.attackSpeed,
    required this.moveSpeed,
    required this.attackBoundaryRadius,
  });

  PlayerModel copyWith({
    double? hp,
    double? attackSpeed,
    double? moveSpeed,
    double? attackBoundaryRadius,
  }) {
    return PlayerModel(
      hp: hp ?? this.hp,
      attackSpeed: attackSpeed ?? this.attackSpeed,
      moveSpeed: moveSpeed ?? this.moveSpeed,
      attackBoundaryRadius: attackBoundaryRadius ?? this.attackBoundaryRadius,
    );
  }

  @override
  List<Object?> get props => [
        hp,
        attackSpeed,
        moveSpeed,
        attackBoundaryRadius,
      ];
}
