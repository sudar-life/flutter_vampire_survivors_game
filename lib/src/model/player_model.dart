import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final double hp;
  final double maxHp;
  final double attackBoundaryRadius;
  final double attackSpeed;
  final double moveSpeed;
  final double xp;
  final double nextLevelXp;
  final int level;

  const PlayerModel({
    required this.hp,
    required this.maxHp,
    required this.attackSpeed,
    required this.moveSpeed,
    required this.attackBoundaryRadius,
    required this.xp,
    required this.nextLevelXp,
    this.level = 1,
  });

  PlayerModel copyWith({
    double? hp,
    double? maxHp,
    double? attackSpeed,
    double? moveSpeed,
    double? attackBoundaryRadius,
    double? xp,
    double? nextLevelXp,
    int? level,
  }) {
    return PlayerModel(
      hp: hp ?? this.hp,
      maxHp: maxHp ?? this.maxHp,
      attackSpeed: attackSpeed ?? this.attackSpeed,
      moveSpeed: moveSpeed ?? this.moveSpeed,
      attackBoundaryRadius: attackBoundaryRadius ?? this.attackBoundaryRadius,
      xp: xp ?? this.xp,
      nextLevelXp: nextLevelXp ?? this.nextLevelXp,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [
        hp,
        maxHp,
        attackSpeed,
        moveSpeed,
        attackBoundaryRadius,
        xp,
        nextLevelXp,
        level,
      ];
}
