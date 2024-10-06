enum StageType {
  stage1(18, 2, 2),
  stage2(25, 3, 2),
  stage3(35, 4, 1.5);

  const StageType(
    this.runningTime,
    this.oneTimeEnemySpotCounts,
    this.responeGapTime,
  );
  final double runningTime;
  final double oneTimeEnemySpotCounts;
  final double responeGapTime;
}
