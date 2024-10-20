import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';
import 'package:vampire_survivors_game/src/components/gui/blink_container_effect_ui.dart';
import 'package:vampire_survivors_game/src/components/gui/item_single_ui.dart';
import 'package:vampire_survivors_game/src/cubit/game_manager.dart';
import 'package:vampire_survivors_game/src/cubit/levelup_item_manager.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';

class ItemSelectUi extends StatelessWidget {
  const ItemSelectUi({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LevelUpItemManager>().state;
    var playerGunSlotCounts =
        context.read<PlayerManager>().state.gunItems?.length ?? 1;
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppFont(
              '레벨업 아이템',
              fontWeight: FontWeight.bold,
              size: 50,
              color: Colors.black,
            ),
            const AppFont(
              '아이템을 선택하여 케릭터를 강화할 수 있습니다. 3가지중 하나만을 선택할 수 있습니다.',
              size: 15,
              color: Colors.black,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                state.items.length,
                (index) => ItemSingleUi(
                  item: state.items[index],
                  isCriticalItem: state.indexCard != null &&
                      state.indexCard == index &&
                      playerGunSlotCounts < 4,
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
        if (state.criticalItem && playerGunSlotCounts < 4)
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: BlinkContainerEffectUi(),
          )
      ],
    );
  }
}
