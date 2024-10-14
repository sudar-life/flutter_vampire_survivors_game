enum ItemType {
  moveSpeedItem([1.0, 3.0, 5.0], ['전술 부츠', '스피드 슬링', '경량 탄띠'], '이속', '%'),
  attackSpeedItem([3.0, 5.0, 10.0], ['빠른 장전기', '자동 조준기', '경량 총열'], '공속', '%'),
  powerItem([0.5, 1.0, 2.0], ['강화 탄환', '폭발성 탄약', '관통탄'], '공격력', '%'),
  luckItem([1.0, 2.0, 4.0], ['황금 탄피', '행운의 방아쇠', '총신의 부적'], '행운', '%'),
  evasionItem([2.0, 3.0, 5.0], ['연막탄 발사기', '회피 장갑', '전술 회피 모듈'], '회피율', '%'),
  maxHpItem([10.0, 20.0, 30.0], ['강화 방탄복', '군용 헬멧', '보호 방패'], '최대 HP', '%'),
  attackAreaItem(
      [10.0, 20.0, 40.0], ['확산 탄약', '산탄총 개조 키트', '폭발 파편 탄환'], '공격범위', ''),
  ;

  const ItemType(this.val, this.itemNames, this.stateLabel, this.unit);
  final List<double> val;
  final String stateLabel;
  final String unit;
  final List<String> itemNames;

  static ItemType getItemType(int random) {
    var value = random.clamp(0, ItemType.values.length - 1);
    return ItemType.values[value];
  }
}
