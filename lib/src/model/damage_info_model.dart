import 'package:vampire_survivors_game/src/model/location_info_model.dart';

enum TargetType { PLAYER, ENEMY }

class DamageInfoModel extends LocationInfoModel {
  final double damage;
  final String id;
  final TargetType targetType;
  final bool isMiss;
  const DamageInfoModel({
    required this.id,
    required super.x,
    required super.y,
    required super.createdAt,
    required this.damage,
    this.targetType = TargetType.ENEMY,
    this.isMiss = false,
  });

  bool isExpired() {
    return DateTime.now().difference(createdAt).inMilliseconds > 500;
  }

  @override
  List<Object?> get props => [
        id,
        x,
        y,
        createdAt,
        damage,
        isMiss,
        targetType,
      ];
}
