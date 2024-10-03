import 'dart:ui';

class GameDataUtil {
  static bool isCircleColliding(
      Offset centerA, double radiusA, Offset centerB, double radiusB) {
    double distance = (centerA - centerB).distance;
    return distance < (radiusA + radiusB);
  }
}
