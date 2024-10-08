import 'package:flutter/material.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';

class DamageEffect extends StatelessWidget {
  final double x;
  final double y;
  final double damage;
  const DamageEffect({
    super.key,
    required this.x,
    required this.y,
    required this.damage,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: AppFont(
        damage.toString(),
        fontWeight: FontWeight.bold,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
