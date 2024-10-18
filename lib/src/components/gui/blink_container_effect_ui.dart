import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlinkContainerEffectUi extends StatefulWidget {
  const BlinkContainerEffectUi({super.key});

  @override
  State<BlinkContainerEffectUi> createState() => _BlinkContainerEffectUiState();
}

class _BlinkContainerEffectUiState extends State<BlinkContainerEffectUi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool offState = false;

  @override
  void initState() {
    super.initState();

    // AnimationController를 생성하여 1초 동안 애니메이션이 반복되도록 설정
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )..repeat(reverse: true); // 반복되며 반대로 애니메이션 적용

    // Tween을 사용하여 흰색에서 투명으로 애니메이션이 진행되도록 설정
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.white.withOpacity(0),
    ).animate(_controller);

    _off();
  }

  Future<void> _off() async {
    await Future.delayed(Duration(milliseconds: 700));
    _controller.stop();
    setState(() {
      offState = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (offState) {
      return Container();
    }
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          color: _colorAnimation.value, // 애니메이션의 색상을 적용
        );
      },
    );
  }
}
