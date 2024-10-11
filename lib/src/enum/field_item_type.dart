import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum FieldItemType {
  XP(Icons.star, Colors.yellow),
  HEAL(Icons.air, Colors.blue);

  const FieldItemType(this.icon, this.color);
  final IconData icon;
  final Color color;
}
