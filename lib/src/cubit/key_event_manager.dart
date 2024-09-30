import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class KeyEventManagerCubit extends Cubit<KeyEventState> {
  KeyEventManagerCubit() : super(const KeyEventState());

  addKey(LogicalKeyboardKey key) {
    emit(state.copyWith(pressedKeys: {...state.pressedKeys, key}));
  }

  removeKey(LogicalKeyboardKey key) {
    state.pressedKeys.remove(key);
    emit(state.copyWith(pressedKeys: {...state.pressedKeys}));
  }
}

class KeyEventState extends Equatable {
  final Set<LogicalKeyboardKey> pressedKeys;
  const KeyEventState({this.pressedKeys = const {}});

  KeyEventState copyWith({
    Set<LogicalKeyboardKey>? pressedKeys,
  }) {
    return KeyEventState(
      pressedKeys: pressedKeys ?? this.pressedKeys,
    );
  }

  @override
  List<Object?> get props => [pressedKeys];
}
