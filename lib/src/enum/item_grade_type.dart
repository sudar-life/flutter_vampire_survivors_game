import 'dart:ui';

import 'package:flutter/material.dart';

enum ItemGradeType {
  normal(60, Colors.grey, '일반'),
  magic(30, Colors.blue, '희귀'),
  rare(10, Colors.orange, '레어');

  const ItemGradeType(this.dropPercent, this.color, this.name);
  final double dropPercent;
  final Color color;
  final String name;

  static ItemGradeType getGradeType(int random, int luckPercent) {
    var normalPercentAdj = normal.dropPercent - luckPercent * 2;
    var magicPercentAdj = magic.dropPercent + luckPercent;
    var rarePercentAdj = rare.dropPercent + luckPercent;

    var totalPercent = normalPercentAdj + magicPercentAdj + rarePercentAdj;
    if (totalPercent > 100) {
      // 비율을 맞추기 위해 각각의 확률을 조정
      normalPercentAdj *= 100 / totalPercent;
      magicPercentAdj *= 100 / totalPercent;
      rarePercentAdj *= 100 / totalPercent;
    }

    if (random < normalPercentAdj) {
      return ItemGradeType.normal;
    } else if (random < normalPercentAdj + magicPercentAdj) {
      return ItemGradeType.magic;
    } else {
      return ItemGradeType.rare;
    }
  }
}
