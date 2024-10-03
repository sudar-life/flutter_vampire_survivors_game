import 'package:flutter/material.dart';

class Enemy extends StatelessWidget {
  final double x;
  final double y;
  final bool isHit;
  const Enemy(
      {super.key, required this.x, required this.y, required this.isHit});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
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
