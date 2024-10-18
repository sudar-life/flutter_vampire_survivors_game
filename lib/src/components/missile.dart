import 'package:flutter/material.dart';
import 'package:vampire_survivors_game/src/enum/gun_type.dart';

class Missile extends StatelessWidget {
  final double x;
  final double y;
  final GunType gunType;
  const Missile(
      {super.key, required this.x, required this.y, required this.gunType});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: gunType.missileSize,
        height: gunType.missileSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: gunType.missileColor,
        ),
      ),
    );
  }
}
