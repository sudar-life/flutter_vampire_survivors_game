import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/item_grade_type.dart';

class LevelUpItemManager extends Cubit<LevelUpItemState> {
  LevelUpItemManager() : super(const LevelUpItemState());

  void makeRandomItems(int luckPercent) {
    var randomItemGrades = <ItemGradeType>[];
    for (var i = 0; i < 3; i++) {
      var random = Random().nextInt(100);
      print(random);
      randomItemGrades.add(ItemGradeType.getGradeType(random, luckPercent));
    }
    randomItemGrades.shuffle();
    emit(state.copyWith(randomItemGrades: randomItemGrades));
  }
}

class LevelUpItemState extends Equatable {
  final List<ItemGradeType> randomItemGrades;

  const LevelUpItemState({this.randomItemGrades = const []});

  LevelUpItemState copyWith({
    List<ItemGradeType>? randomItemGrades,
  }) {
    return LevelUpItemState(
      randomItemGrades: randomItemGrades ?? this.randomItemGrades,
    );
  }

  @override
  List<Object?> get props => [
        randomItemGrades,
      ];
}
