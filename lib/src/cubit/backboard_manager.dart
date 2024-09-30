import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BackboardManager extends Cubit<BackboardState> {
  BackboardManager() : super(const BackboardState());
  updateGameZoneSize(double gameZoneWidth, double gameZoneHeight) {
    emit(state.copyWith(
      gameZoneWidth: gameZoneWidth,
      gameZoneHeight: gameZoneHeight,
    ));
  }

  moveBackground({
    required double directionX,
    required double directionY,
    required double playerMoveX,
    required double playerMoveY,
    required double speed,
  }) {
    var newBackgroundMoveX = state.backgroundMoveX;
    var newBackgroundMoveY = state.backgroundMoveY;
    if (state.backgroundMoveX > state.gameZoneWidth / 2 * 1.5) {
      newBackgroundMoveX = state.gameZoneWidth / 2 * 1.5;
    }
    if (state.backgroundMoveX < -state.gameZoneWidth / 2 * 1.5) {
      newBackgroundMoveX = -state.gameZoneWidth / 2 * 1.5;
    }
    if (state.backgroundMoveY > state.gameZoneHeight / 2 * 1.5) {
      newBackgroundMoveY = state.gameZoneHeight / 2 * 1.5;
    }
    if (state.backgroundMoveY < -state.gameZoneHeight / 2 * 1.5) {
      newBackgroundMoveY = -state.gameZoneHeight / 2 * 1.5;
    }
    if (playerMoveX > state.gameZoneWidth / 2 * 1.5 ||
        playerMoveX < -state.gameZoneWidth / 2 * 1.5) {
      if (playerMoveY > state.gameZoneHeight / 2 * 1.5 ||
          playerMoveY < -state.gameZoneHeight / 2 * 1.5) {
        emit(state.copyWith(
          backgroundMoveX: newBackgroundMoveX,
          backgroundMoveY: newBackgroundMoveY,
        ));
        return;
      } else {
        newBackgroundMoveY -= directionY * speed;
        emit(state.copyWith(
          backgroundMoveX: newBackgroundMoveX,
          backgroundMoveY: newBackgroundMoveY,
        ));
      }
      return;
    }
    if (playerMoveY > state.gameZoneHeight / 2 * 1.5 ||
        playerMoveY < -state.gameZoneHeight / 2 * 1.5) {
      if (playerMoveX > state.gameZoneWidth / 2 * 1.5 ||
          playerMoveX < -state.gameZoneWidth / 2 * 1.5) {
        emit(state.copyWith(
          backgroundMoveX: newBackgroundMoveX,
          backgroundMoveY: newBackgroundMoveY,
        ));
        return;
      } else {
        newBackgroundMoveX -= directionX * speed;
        emit(state.copyWith(
          backgroundMoveX: newBackgroundMoveX,
          backgroundMoveY: newBackgroundMoveY,
        ));
      }
      return;
    }
    newBackgroundMoveX -= directionX * speed;
    newBackgroundMoveY -= directionY * speed;
    emit(state.copyWith(
      backgroundMoveX: newBackgroundMoveX,
      backgroundMoveY: newBackgroundMoveY,
    ));
  }
}

class BackboardState extends Equatable {
  final double gameZoneWidth;
  final double gameZoneHeight;

  final double backgroundMoveX;
  final double backgroundMoveY;
  const BackboardState({
    this.gameZoneWidth = 0.0,
    this.gameZoneHeight = 0.0,
    this.backgroundMoveX = 0.0,
    this.backgroundMoveY = 0.0,
  });

  BackboardState copyWith({
    double? gameZoneWidth,
    double? gameZoneHeight,
    double? backgroundMoveX,
    double? backgroundMoveY,
  }) {
    return BackboardState(
      gameZoneWidth: gameZoneWidth ?? this.gameZoneWidth,
      gameZoneHeight: gameZoneHeight ?? this.gameZoneHeight,
      backgroundMoveX: backgroundMoveX ?? this.backgroundMoveX,
      backgroundMoveY: backgroundMoveY ?? this.backgroundMoveY,
    );
  }

  @override
  List<Object?> get props => [
        gameZoneWidth,
        gameZoneHeight,
        backgroundMoveX,
        backgroundMoveY,
      ];
}
