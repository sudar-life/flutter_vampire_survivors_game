import 'package:vampire_survivors_game/src/model/location_info_model.dart';

class DamageInfoModel extends LocationInfoModel {
  final double damage;
  final String id;
  const DamageInfoModel({
    required this.id,
    required super.x,
    required super.y,
    required super.createdAt,
    required this.damage,
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
      ];
}
