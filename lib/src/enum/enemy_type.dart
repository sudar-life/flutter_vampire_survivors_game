enum EnemyType {
  noraml1(hp: 10, xp: 15, speed: 3, power: 10, defense: 1),
  normal2(hp: 15, xp: 20, speed: 3, power: 10, defense: 1),
  normal3(hp: 18, xp: 25, speed: 4, power: 10, defense: 1),
  middleBoss1(hp: 30, xp: 30, speed: 3, power: 15, defense: 2),
  middleBoss2(hp: 60, xp: 35, speed: 2, power: 20, defense: 2),
  boss1(hp: 100, xp: 50, speed: 2, power: 30, defense: 4),
  boss2(hp: 150, xp: 80, speed: 4, power: 35, defense: 6);

  const EnemyType({
    required this.hp,
    required this.xp,
    required this.speed,
    required this.power,
    required this.defense,
  });
  final double hp;
  final double xp;
  final double speed;
  final double power;
  final double defense;
}
