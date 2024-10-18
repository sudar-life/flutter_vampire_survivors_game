import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/gun_sector_type.dart';
import 'package:vampire_survivors_game/src/enum/gun_type.dart';

class GunItem extends Equatable {
  final GunType gunType;
  final DateTime? lastMissileShotTime;
  final GunSectorType gunSectorType;

  const GunItem({
    required this.gunType,
    required this.gunSectorType,
    this.lastMissileShotTime,
  });

  GunItem copyWith({
    GunType? gunType,
    GunSectorType? gunSectorType,
    DateTime? lastMissileShotTime,
  }) {
    return GunItem(
      gunType: gunType ?? this.gunType,
      gunSectorType: gunSectorType ?? this.gunSectorType,
      lastMissileShotTime: lastMissileShotTime ?? this.lastMissileShotTime,
    );
  }

  @override
  List<Object?> get props => [gunType, gunSectorType, lastMissileShotTime];
}
