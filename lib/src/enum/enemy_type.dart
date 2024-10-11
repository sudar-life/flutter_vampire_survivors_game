enum EnemyType {
  noraml1(10, 10, 3, 0.5, 1),
  normal2(15, 10, 3, 0.5, 1),
  normal3(12, 10, 5, 0.5, 1),
  middleBoss1(30, 20, 3, 1.5, 2),
  middleBoss2(60, 35, 2, 2, 2),
  boss1(100, 50, 2, 4, 4),
  boss2(150, 80, 4, 3, 6);

  const EnemyType(
    this.hp,
    this.xp,
    this.speed,
    this.power,
    this.defense,
  );
  final double hp;
  final double xp;
  final double speed;
  final double power;
  final double defense;
}
