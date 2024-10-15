import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/item_type.dart';
import 'package:vampire_survivors_game/src/model/item_model.dart';

class ItemValue extends Equatable {
  final double totalValue;
  final ItemType? itemType;

  const ItemValue({
    this.totalValue = 0,
    this.itemType,
  });

  ItemValue addValue({
    double? totalValue,
    ItemType? itemType,
  }) {
    return ItemValue(
      totalValue: this.totalValue + totalValue!,
      itemType: itemType ?? this.itemType,
    );
  }

  @override
  List<Object?> get props => [
        totalValue,
        itemType,
      ];
}

class Inventory extends Equatable {
  final List<ItemModel> items;
  final ItemValue moveSpeedItem;
  final ItemValue attackSpeedItem;
  final ItemValue powerItem;
  final ItemValue luckItem;
  final ItemValue evasionItem;
  final ItemValue maxHpItem;
  final ItemValue attackAreaItem;

  const Inventory({
    this.items = const [],
    this.moveSpeedItem = const ItemValue(),
    this.attackSpeedItem = const ItemValue(),
    this.powerItem = const ItemValue(),
    this.luckItem = const ItemValue(),
    this.evasionItem = const ItemValue(),
    this.maxHpItem = const ItemValue(),
    this.attackAreaItem = const ItemValue(),
  });

  Inventory addItem({
    required ItemModel item,
  }) {
    var gradeIndex = item.gradeType!.index;
    var spreadItems = [item.mainItem, ...item.subItems!];
    var moveSpeedItem = this.moveSpeedItem;
    var attackSpeedItem = this.attackSpeedItem;
    var powerItem = this.powerItem;
    var luckItem = this.luckItem;
    var evasionItem = this.evasionItem;
    var maxHpItem = this.maxHpItem;
    var attackAreaItem = this.attackAreaItem;
    spreadItems.map((e) {
      switch (e!) {
        case ItemType.moveSpeedItem:
          moveSpeedItem = moveSpeedItem.addValue(totalValue: e.val[gradeIndex]);
          break;
        case ItemType.attackSpeedItem:
          attackSpeedItem =
              attackSpeedItem.addValue(totalValue: e.val[gradeIndex]);
          break;
        case ItemType.powerItem:
          powerItem = powerItem.addValue(totalValue: e.val[gradeIndex]);
          break;
        case ItemType.luckItem:
          luckItem = luckItem.addValue(totalValue: e.val[gradeIndex]);
          break;
        case ItemType.evasionItem:
          evasionItem = evasionItem.addValue(totalValue: e.val[gradeIndex]);
          break;
        case ItemType.maxHpItem:
          maxHpItem = maxHpItem.addValue(totalValue: e.val[gradeIndex]);
          break;
        case ItemType.attackAreaItem:
          attackAreaItem =
              attackAreaItem.addValue(totalValue: e.val[gradeIndex]);
          break;
      }
    }).toList();

    return Inventory(
      items: [...items, item],
      moveSpeedItem: moveSpeedItem,
      attackSpeedItem: attackSpeedItem,
      powerItem: powerItem,
      luckItem: luckItem,
      evasionItem: evasionItem,
      maxHpItem: maxHpItem,
      attackAreaItem: attackAreaItem,
    );
  }

  @override
  List<Object?> get props => [
        items,
        moveSpeedItem,
        attackSpeedItem,
        powerItem,
        luckItem,
        evasionItem,
        maxHpItem,
        attackAreaItem,
      ];
}
