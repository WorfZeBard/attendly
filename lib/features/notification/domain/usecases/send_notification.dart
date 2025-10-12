// usecases/send_booking_notification.dart
import 'package:dartz/dartz.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';
import '../../../../core/error/failures.dart';

class SendBookingNotification {
  final NotificationRepository repository;

  SendBookingNotification(this.repository);

  Future<Either<Failure, BookingNotification>> call(
    BookingNotification notification,
  ) async {
    return await repository.sendNotification(notification);
  }
}


