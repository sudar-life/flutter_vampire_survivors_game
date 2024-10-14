import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/item_grade_type.dart';
import 'package:vampire_survivors_game/src/enum/item_type.dart';
import 'package:vampire_survivors_game/src/model/item_model.dart';

class LevelUpItemManager extends Cubit<LevelUpItemState> {
  LevelUpItemManager() : super(const LevelUpItemState());

  ItemType _makeItem({List<ItemType>? excepItems}) {
    var getItem =
        ItemType.getItemType(Random().nextInt(ItemType.values.length));
    if (excepItems != null) {
      while (excepItems.contains(getItem)) {
        getItem =
            ItemType.getItemType(Random().nextInt(ItemType.values.length));
      }
    }
    return getItem;
  }

  void makeRandomItems(int luckPercent) {
    var items = <ItemModel>[];
    for (var i = 0; i < 3; i++) {
      var random = Random().nextInt(100);
      var mainItem = _makeItem();
      var grade = ItemGradeType.getGradeType(random, luckPercent);
      var subItems = <ItemType>[];
      if (grade == ItemGradeType.magic) {
        subItems.add(_makeItem(excepItems: [mainItem]));
      } else if (grade == ItemGradeType.rare) {
        var firstItem = _makeItem(excepItems: [mainItem]);
        subItems.add(firstItem);
        subItems.add(_makeItem(excepItems: [mainItem, firstItem]));
      }
      items.add(ItemModel(
          mainItem: mainItem,
          subItems: subItems,
          gradeType: grade,
          itmeName: mainItem.itemNames[Random().nextInt(3)]));
    }
    items.shuffle();
    emit(state.copyWith(items: items));
  }
}

class LevelUpItemState extends Equatable {
  final List<ItemModel> items;

  const LevelUpItemState({this.items = const []});

  LevelUpItemState copyWith({
    List<ItemModel>? items,
  }) {
    return LevelUpItemState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
        items,
      ];
}
