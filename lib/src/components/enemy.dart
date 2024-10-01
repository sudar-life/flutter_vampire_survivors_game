import 'package:flutter/material.dart';

class Enemy extends StatelessWidget {
  final double x;
  final double y;
  const Enemy({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
