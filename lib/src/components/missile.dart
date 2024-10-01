import 'package:flutter/material.dart';

class Missile extends StatelessWidget {
  final double x;
  final double y;
  const Missile({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}
