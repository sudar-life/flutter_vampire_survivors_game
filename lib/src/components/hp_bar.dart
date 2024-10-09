import 'package:flutter/material.dart';

class HpBar extends StatelessWidget {
  final double hp;
  final double maxHp;
  const HpBar({
    super.key,
    required this.hp,
    required this.maxHp,
  });

  @override
  Widget build(BuildContext context) {
    var width = (hp / maxHp) * 50;
    return Container(
      width: 50,
      height: 8,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.grey,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: width,
          color: Colors.red,
        ),
      ),
    );
  }
}
