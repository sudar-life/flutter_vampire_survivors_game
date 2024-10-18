import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/components/app_font.dart';
import 'package:vampire_survivors_game/src/cubit/game_manager.dart';
import 'package:vampire_survivors_game/src/cubit/levelup_item_manager.dart';
import 'package:vampire_survivors_game/src/cubit/player_manager.dart';
import 'package:vampire_survivors_game/src/enum/gun_sector_type.dart';
import 'package:vampire_survivors_game/src/enum/gun_type.dart';
import 'package:vampire_survivors_game/src/model/gun_item_model.dart';
import 'package:vampire_survivors_game/src/model/item_model.dart';

class ItemSingleUi extends StatefulWidget {
  final ItemModel item;
  final bool isCriticalItem;
  const ItemSingleUi({
    super.key,
    required this.item,
    this.isCriticalItem = false,
  });

  @override
  State<ItemSingleUi> createState() => _ItemSingleUiState();
}

class _ItemSingleUiState extends State<ItemSingleUi> {
  GunType? gunType;
  @override
  void initState() {
    super.initState();
    if (widget.isCriticalItem) {
      changeGunItem();
    }
  }

  void changeGunItem() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      gunType = GunType.values[Random().nextInt(GunType.values.length)];
    });
  }

  Widget _subItemDescription() {
    return Column(
      children: [
        AppFont(
          '${widget.item.mainItem!.stateLabel} ${widget.item.mainItem!.val[widget.item.gradeType!.index]}${widget.item.mainItem!.unit}증가',
          size: 13,
          color: Colors.black,
        ),
        if ((widget.item.subItems ?? []).isNotEmpty)
          ...widget.item.subItems!
              .map(
                (subItem) => AppFont(
                  '${subItem.stateLabel} ${subItem.val[widget.item.gradeType!.index]}${subItem.unit}증가',
                  size: 13,
                  color: Colors.black,
                ),
              )
              .toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GameManager>().gameResume();
        if (gunType != null) {
          var emptyHands = <GunSectorType>[];
          GunSectorType.values.forEach((sectorType) {
            var gitem =
                context.read<PlayerManager>().state.gunItems![sectorType];
            if (gitem == null) {
              emptyHands.add(sectorType);
            }
          });
          context.read<PlayerManager>().getTheGun(GunItem(
              gunType: gunType!,
              gunSectorType: emptyHands.first,
              lastMissileShotTime: DateTime.now()));
          context.read<LevelUpItemManager>().clearCriticalItem();
        } else {
          context.read<PlayerManager>().upgradeItem(widget.item);
        }
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: gunType != null ? Colors.purple : Colors.white,
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
                color: gunType != null
                    ? gunType!.missileColor
                    : widget.item.gradeType!.color,
              ),
            ),
            const SizedBox(height: 10),
            AppFont(
              gunType != null
                  ? gunType!.name
                  : '${widget.item.itmeName} (${widget.item.gradeType!.name} 등급)',
              size: 16,
              color:
                  gunType != null ? Colors.white : widget.item.gradeType!.color,
            ),
            const SizedBox(height: 10),
            if (gunType == null) _subItemDescription()
          ],
        ),
      ),
    );
  }
}
