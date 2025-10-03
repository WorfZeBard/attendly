// repositories/notification_repository.dart
import 'package:dartz/dartz.dart';
import '../../../user/domain/failures/failure.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, BookingNotification>> sendNotification(
    BookingNotification notification,
  );
}


