import 'package:equatable/equatable.dart';
import 'package:vampire_survivors_game/src/enum/field_item_type.dart';

class FieldItemModel extends Equatable {
  final double areaWidth;
  final double areaHeight;
  final FieldItemType type;
  final double value;
  final double x;
  final double y;

  const FieldItemModel({
    this.areaWidth = 0.0,
    this.areaHeight = 0.0,
    required this.type,
    required this.value,
    required this.x,
    required this.y,
  });

  FieldItemModel copyWith({
    double? areaWidth,
    double? areaHeight,
    FieldItemType? type,
    double? value,
    double? x,
    double? y,
  }) {
    return FieldItemModel(
      areaWidth: areaWidth ?? this.areaWidth,
      areaHeight: areaHeight ?? this.areaHeight,
      type: type ?? this.type,
      value: value ?? this.value,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  double get tx => areaWidth / 2 - 5 + x;
  double get ty => areaHeight / 2 - 5 + y;

  @override
  List<Object?> get props => [
        areaWidth,
        areaHeight,
        type,
        value,
        x,
        y,
      ];
}
