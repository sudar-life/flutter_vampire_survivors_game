import 'package:flutter/material.dart';
import 'package:vampire_survivors_game/src/enum/enemy_state_type.dart';
import 'package:vampire_survivors_game/src/enum/field_item_type.dart';

class FieldItem extends StatelessWidget {
  final double x;
  final double y;
  final FieldItemType type;
  const FieldItem({
    super.key,
    required this.x,
    required this.y,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Icon(type.icon, size: 12, color: type.color),
    );
  }
}
