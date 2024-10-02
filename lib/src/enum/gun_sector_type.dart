import 'dart:ui';

enum GunSectorType {
  LEFT(Offset(-10, 10)),
  RIGHT(Offset(30, 10)),
  TOP(Offset(12, -8)),
  BOTTOM(Offset(12, 33));

  const GunSectorType(this.adjustPoint);
  final Offset adjustPoint;
}
