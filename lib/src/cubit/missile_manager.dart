import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vampire_survivors_game/src/model/missile_model.dart';

class MissileManager extends Cubit<MissileState> {
  double? width;
  double? height;
  MissileManager() : super(const MissileState());

  shotMissile(
    double width,
    double height,
    double sx,
    double sy,
    double tx,
    double ty,
  ) {
    this.width = width;
    this.height = height;
    var x = width / 2 - 15 + sx;
    var y = height / 2 - 15 + sy;
    print('sx $x sy $y tx $ty ty $ty');
    var missile = MissileModel(
      x: x,
      y: y,
      dx: tx,
      dy: ty,
      speed: 3 * width / 3,
      power: 1,
    );
    emit(state.copyWith(missiles: [...state.missiles, missile]));
  }

  moveMissile() {
    var newMissiles =
        state.missiles.where((element) => element != null).map((missile) {
      var x = missile!.x;
      var y = missile.y;
      var dx = missile.dx - x;
      var dy = missile.dy - y;
      var distance = (dx * dx + dy * dy);
      var vx = dx / distance;
      var vy = dy / distance;
      if (distance < 1000 || x < 0 || y < 0 || x > width! || y > height!) {
        return null;
      }
      return missile.copyWith(
          x: x + vx * missile.speed, y: y + vy * missile.speed);
    });
    emit(state.copyWith(missiles: [...newMissiles]));
  }
}

class MissileState extends Equatable {
  final List<MissileModel?> missiles;
  const MissileState({
    this.missiles = const [],
  });

  MissileState copyWith({
    List<MissileModel?>? missiles,
  }) {
    return MissileState(
      missiles: missiles ?? this.missiles,
    );
  }

  @override
  List<Object> get props => [missiles];
}
