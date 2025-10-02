// entities/service.dart
import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final String id;
  final String professionalId;
  final String name;
  final int durationMinutes;
  final double price;

  const Service({
    required this.id,
    required this.professionalId,
    required this.name,
    required this.durationMinutes,
    required this.price,
  });

  @override
  List<Object?> get props => [id, professionalId, name, durationMinutes, price];
}
