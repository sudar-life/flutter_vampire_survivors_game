import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';
import 'package:vampire_survivors_game/src/model/player_model.dart';

class XpBar extends StatefulWidget {
  const XpBar({super.key});

  @override
  State<XpBar> createState() => _XpBarState();
}

class _XpBarState extends State<XpBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var player = context
        .select<PlayerManager, PlayerModel>((value) => value.state.playerModel);
    return LayoutBuilder(builder: (context, constrant) {
      var maxXp = player.nextLevelXp;
      var currentXp = player.xp;
      var width = constrant.maxWidth * currentXp / maxXp;
      return Container(
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.white.withOpacity(0.5),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Stack(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: width,
              color: Colors.blue,
            ),
          ),
          Positioned(
            top: 0,
            left: 5,
            child: AppFont(
              'Lv.${player.level} - ${player.xp}',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              size: 12,
            ),
          ),
        ]),
      );
    });
  }
}
