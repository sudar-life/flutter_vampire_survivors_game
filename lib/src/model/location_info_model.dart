import 'package:equatable/equatable.dart';

class LocationInfoModel extends Equatable {
  final double x;
  final double y;
  final DateTime createdAt;

  const LocationInfoModel({
    required this.x,
    required this.y,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [
        x,
        y,
        createdAt,
      ];
}
