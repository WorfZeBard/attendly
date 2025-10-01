// repositories/notification_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/notification.dart';
import '../../../core/error/failures.dart';

abstract class NotificationRepository {
  Future<Either<Failure, BookingNotification>> sendNotification(
    BookingNotification notification,
  );
}
