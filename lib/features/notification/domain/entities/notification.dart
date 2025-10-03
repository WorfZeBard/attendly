// entities/notification.dart
import 'package:equatable/equatable.dart';

class BookingNotification extends Equatable {
  final String id;
  final String userId;
  final String message;
  final DateTime timestamp;

  const BookingNotification({
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, userId, message, timestamp];
}


