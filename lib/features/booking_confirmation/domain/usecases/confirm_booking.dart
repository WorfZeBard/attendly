import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_confirmation.dart';
import '../repositories/booking_confirmation_repository.dart';

class ConfirmBooking {
  final BookingConfirmationRepository repository;

  ConfirmBooking(this.repository);

  Future<Either<Failure, BookingConfirmation>> call({
    required String bookingId,
    required String clientId,
    required String professionalId,
    required DateTime confirmedAt,
  }) async {
    return await repository.confirmBooking(
      bookingId: bookingId,
      clientId: clientId,
      professionalId: professionalId,
      confirmedAt: confirmedAt,
    );
  }
}
