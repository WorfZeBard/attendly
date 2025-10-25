import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_confirmation.dart';

abstract class BookingConfirmationRepository {
  Future<Either<Failure, BookingConfirmation>> confirmBooking({
    required String bookingId,
    required String clientId,
    required String professionalId,
    required DateTime confirmedAt,
  });

  Future<Either<Failure, BookingConfirmation>> getBookingConfirmation(
    String bookingId,
  );
}
