import 'package:vampire_survivors_game/src/enum/enemy_type.dart';

enum StageType {
  stage1(
    18,
    2,
    2,
    [
      EnemyType.noraml1,
      EnemyType.normal2,
      EnemyType.normal3,
    ],
  ),
  stage2(
    25,
    3,
    2,
    [
      EnemyType.noraml1,
      EnemyType.normal2,
      EnemyType.normal3,
      EnemyType.middleBoss1,
    ],
  ),
  stage3(35, 4, 1.5, [
    EnemyType.noraml1,
    EnemyType.normal2,
    EnemyType.normal3,
    EnemyType.middleBoss1,
    EnemyType.middleBoss2,
  ]),
  stage4(50, 5, 1.5, [
    EnemyType.noraml1,
    EnemyType.normal2,
    EnemyType.normal3,
    EnemyType.middleBoss1,
    EnemyType.middleBoss2,
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
