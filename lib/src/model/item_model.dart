import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/item_grade_type.dart';
import 'package:vampire_survivors_game/src/enum/item_type.dart';

class ItemModel extends Equatable {
  final ItemGradeType? gradeType;
  final ItemType? mainItem;
  final String? itmeName;
  final List<ItemType>? subItems;
  const ItemModel({
    this.gradeType,
    this.mainItem,
    this.itmeName,
    this.subItems,
  });

  @override
  List<Object?> get props => [
        gradeType,
        mainItem,
        subItems,
        itmeName,
      ];
}
