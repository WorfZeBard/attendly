// entities/booking.dart
import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String id;
  final String clientId;
  final String professionalId;
  final DateTime dateTime;

  const Booking({
    required this.id,
    required this.clientId,
    required this.professionalId,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [id, clientId, professionalId, dateTime];
}


