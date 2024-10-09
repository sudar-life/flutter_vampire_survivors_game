import 'dart:html';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/model/damage_info_model.dart';
import 'package:vampire_survivors_game/src/model/location_info_model.dart';

class DamageEffectManager extends Cubit<DamageEffectState> {
  DamageEffectManager() : super(DamageEffectState());

  void addDamage(DamageInfoModel damageInfo) {
    var isEmpty = state.damagedPoints.where((p) => p == damageInfo).isEmpty;
    if (isEmpty) {
      emit(state.copyWith(
        damagedPoints: {
          ...state.damagedPoints,
          damageInfo,
        },
      ));
    }
  }

  void removeDamageEffect() {
    state.damagedPoints.removeWhere((item) => item.isExpired());
    emit(state.copyWith(
      damagedPoints: {...state.damagedPoints},
    ));
  }

  void clear() {
    emit(state.copyWith(
      damagedPoints: {},
    ));
  }
}

class DamageEffectState extends Equatable {
  final Set<DamageInfoModel> damagedPoints;
  const DamageEffectState({
    this.damagedPoints = const {},
  });

  DamageEffectState copyWith({
    Set<DamageInfoModel>? damagedPoints,
  }) {
    return DamageEffectState(
      damagedPoints: damagedPoints ?? this.damagedPoints,
    );
  }

  @override
  List<Object?> get props => [damagedPoints];
}
