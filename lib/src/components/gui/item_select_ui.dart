import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';
import 'package:vampire_survivors_game/src/cubit/levelup_item_manager.dart';

class ItemSelectUi extends StatelessWidget {
  const ItemSelectUi({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LevelUpItemManager>().state;
    return Column(
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
            state.randomItemGrades.length,
            (index) => Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: state.randomItemGrades[index].color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppFont(
                    'XXX 아이템 (${state.randomItemGrades[index].name} 등급)',
                    size: 16,
                    color: state.randomItemGrades[index].color,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
