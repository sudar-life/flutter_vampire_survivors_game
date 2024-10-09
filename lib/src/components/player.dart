import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/hp_bar.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';

class Player extends StatelessWidget {
  final double backgroundHeight;
  final double backgroundWidth;
  const Player(
      {super.key,
      required this.backgroundHeight,
      required this.backgroundWidth});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<PlayerManager>();
    var state = cubit.state;
    var x = backgroundWidth / 2 + state.playerMoveX;
    var y = backgroundHeight / 2 + state.playerMoveY;
    return Positioned(
      left: x - state.playerModel.attackBoundaryRadius,
      top: y - state.playerModel.attackBoundaryRadius,
      child: Stack(
        children: [
          Container(
            width: state.playerModel.attackBoundaryRadius * 2,
            height: state.playerModel.attackBoundaryRadius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffF4FFF1).withOpacity(0.2),
              border: Border.all(
                color: const Color(0xffCAFBCD).withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          Positioned(
            left: state.playerModel.attackBoundaryRadius - 25,
            top: state.playerModel.attackBoundaryRadius - 25,
            child: Container(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state.isHit
                            ? Color.fromARGB(255, 150, 21, 11)
                            : Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 20,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 20,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
                child: HpBar(
              hp: state.playerModel.hp,
              maxHp: state.playerModel.maxHp,
            )),
          )
        ],
      ),
    );
  }
}
