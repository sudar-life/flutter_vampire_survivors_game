import 'package:vampire_survivors_game/src/enum/enemy_type.dart';

enum StageType {
  stage1(
    30,
    2,
    4,
    [
      EnemyType.noraml1,
      EnemyType.normal2,
      EnemyType.normal3,
    ],
  ),
  stage2(
    45,
    3,
    2,
    [
      EnemyType.noraml1,
      EnemyType.normal2,
      EnemyType.normal3,
      EnemyType.middleBoss1,
    ],
  ),
  stage3(60, 4, 1.5, [
    EnemyType.noraml1,
    EnemyType.normal2,
    EnemyType.normal3,
    EnemyType.middleBoss1,
    EnemyType.middleBoss2,
  ]),
  stage4(90, 5, 1.5, [
    EnemyType.noraml1,
    EnemyType.normal2,
    EnemyType.normal3,
    EnemyType.middleBoss1,
    EnemyType.middleBoss2,
  ]),
  stage5(120, 5, 1.5, [
    EnemyType.normal3,
    EnemyType.middleBoss1,
    EnemyType.middleBoss2,
    EnemyType.boss1
  ]),
  ;

  const StageType(
    this.runningTime,
    this.oneTimeEnemySpotCounts,
    this.responeGapTime,
    this.stagePerEnemyTypes,
  );
  final double runningTime;
  final double oneTimeEnemySpotCounts;
  final double responeGapTime;
  final List<EnemyType> stagePerEnemyTypes;
}
