import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/game_type.dart';

class GameManager extends Cubit<GameState> {
  GameManager() : super(const GameState());

  gameStart() {
    emit(state.copyWith(gameType: GameType.start));
  }

  gamePause() {
    emit(state.copyWith(gameType: GameType.pause));
  }

  gameResume() {
    emit(state.copyWith(gameType: GameType.resume));
  }

  gameEnd() {
    emit(state.copyWith(gameType: GameType.end));
  }
}

class GameState extends Equatable {
  final GameType gameType;
  const GameState({this.gameType = GameType.idle});

  GameState copyWith({
    GameType? gameType,
  }) {
    return GameState(
      gameType: gameType ?? this.gameType,
    );
  }

  @override
  List<Object?> get props => [
        gameType,
      ];
}
