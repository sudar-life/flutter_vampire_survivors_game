import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  final double areaWidth;
  final double areaHeight;
  const BackgroundDecoration({
    super.key,
    required this.areaWidth,
    required this.areaHeight,
  });

  @override
  Widget build(BuildContext context) {
    var randomGrass = <Offset>[];
    var r = Random(1);
    for (int i = 0; i < 50; i++) {
      var x = r.nextDouble() * areaWidth;
      var y = r.nextDouble() * areaHeight;
      randomGrass.add(Offset(x, y));
    }
    return Stack(
      children: List.generate(
        randomGrass.length,
        (index) => Positioned(
          left: randomGrass[index].dx,
          top: randomGrass[index].dy,
          child: Image.asset('assets/images/grass.png'),
        ),
      ),
    );
  }
}
