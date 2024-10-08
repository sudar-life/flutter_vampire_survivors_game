import 'package:flutter/material.dart';
import 'package:vampire_survivors_game/src/enum/enemy_state_type.dart';

class Enemy extends StatelessWidget {
  final double x;
  final double y;
  final bool isHit;
  final EnemyStateType type;
  const Enemy({
    super.key,
    required this.x,
    required this.y,
    required this.isHit,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (type == EnemyStateType.DEAD) return Container();
    return Positioned(
      left: x,
      top: y,
      child: type == EnemyStateType.READY
          ? Icon(Icons.close, size: 30, color: Colors.red)
          : Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHit ? Colors.white : Colors.red,
              ),
            ),
    );
  }
}
