import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/game_type.dart';
import 'package:vampire_survivors_game/src/enum/stage_type.dart';

class GameManager extends Cubit<GameState> {
  GameManager() : super(const GameState());

  gameStart() {
    emit(state.copyWith(
      gameType: GameType.start,
      stage: StageType.stage1,
    ));
  }

  gameRestart() {
    emit(state.copyWith(
      gameType: GameType.restart,
    ));
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

  nextStage() {
    emit(state.copyWith(stage: StageType.values[state.stage.index + 1]));
  }
}

class GameState extends Equatable {
  final GameType gameType;
  final StageType stage;
  const GameState({
    this.gameType = GameType.idle,
    this.stage = StageType.stage1,
  });

  GameState copyWith({
    GameType? gameType,
    StageType? stage,
  }) {
    return GameState(
      gameType: gameType ?? this.gameType,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object?> get props => [
        gameType,
        stage,
      ];
}
