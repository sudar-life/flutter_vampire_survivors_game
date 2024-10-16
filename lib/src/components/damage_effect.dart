import 'package:flutter/material.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';

class DamageEffect extends StatefulWidget {
  final double x;
  final double y;
  final double damage;
  final Color color;
  final bool isMiss;
  const DamageEffect({
    super.key,
    required this.x,
    required this.y,
    required this.damage,
    required this.color,
    required this.isMiss,
  });

  @override
  State<DamageEffect> createState() => _DamageEffectState();
}

class _DamageEffectState extends State<DamageEffect> {
  double tx = 0;
  double ty = 0;
  double opacity = 1;
  @override
  void initState() {
    super.initState();
    tx = widget.x;
    ty = widget.y;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _next();
    });
  }

  void _next() {
    setState(() {
      ty -= 30;
      opacity = 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      left: tx,
      top: ty,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: opacity,
        child: AppFont(
          widget.isMiss ? 'MISS' : widget.damage.toString(),
          fontWeight: FontWeight.bold,
          color: widget.isMiss ? Colors.yellow : widget.color,
          size: 20,
        ),
      ),
    );
  }
}
