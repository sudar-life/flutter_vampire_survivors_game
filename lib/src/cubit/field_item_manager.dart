import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/model/field_item_model.dart';
import 'package:vampire_survivors_game/src/utils/data_util.dart';

class FieldItemManager extends Cubit<FieldItemState> {
  FieldItemManager() : super(const FieldItemState());

  void addFieldItem(FieldItemModel fieldItem) {
    emit(state.copyWith(
      fieldItems: {
        ...state.fieldItems,
        fieldItem,
      },
    ));
  }

  void removeFieldItem(FieldItemModel fieldItem) {
    emit(state.copyWith(
      fieldItems:
          state.fieldItems.where((item) => item != fieldItem).toList().toSet(),
    ));
  }

  void clearGetItems() {
    emit(state.copyWith(getItems: {}));
  }

  void checkColliding(double px, double py, double radius) {
    Set<FieldItemModel> getItems = {};
    var fieldItems = {...state.fieldItems};
    fieldItems.removeWhere((fieldItem) {
      var x = fieldItem.x;
      var y = fieldItem.y;
      var centerA = Offset(x, y);
      var centerB = Offset(px, py);
      var radiusA = radius;
      var radiusB = 10.0;
      var isHit = GameDataUtil.isCircleColliding(
        centerA,
        radiusA,
        centerB,
        radiusB,
      );
      if (isHit) {
        getItems.add(fieldItem);
      }
      return isHit;
    });
    emit(state.copyWith(
      fieldItems: {...fieldItems},
      getItems: {...state.getItems, ...getItems},
    ));
  }
}

class FieldItemState extends Equatable {
  final Set<FieldItemModel> fieldItems;
  final Set<FieldItemModel> getItems;
  const FieldItemState({
    this.fieldItems = const {},
    this.getItems = const {},
  });

  FieldItemState copyWith({
    Set<FieldItemModel>? fieldItems,
    Set<FieldItemModel>? getItems,
  }) {
    return FieldItemState(
      fieldItems: fieldItems ?? this.fieldItems,
      getItems: getItems ?? this.getItems,
    );
  }

  @override
  List<Object?> get props => [
        fieldItems,
        getItems,
      ];
}
