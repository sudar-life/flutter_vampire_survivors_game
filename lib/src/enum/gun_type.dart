import 'dart:ui';

import 'package:flutter/material.dart';

enum GunType {
  Pistal(15, 1, 10, Colors.black, 10, '권총'),
  M4(12, 0.3, 13, Colors.red, 7, 'M4'),
  Magnum(20, 2, 20, Colors.blue, 15, '매그넘'),
  ;

  const GunType(
    this.bulletSpeed,
    this.fireRate,
    this.bulletPower,
    this.missileColor,
    this.missileSize,
    this.name,
  );

  final double bulletSpeed;
  final double fireRate;
  final double bulletPower;
  final Color missileColor;
  final double missileSize;
  final String name;
}
