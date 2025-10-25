import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_confirmation.dart';
import '../repositories/booking_confirmation_repository.dart';

class GetBookingConfirmation {
  final BookingConfirmationRepository repository;

  GetBookingConfirmation(this.repository);

  Future<Either<Failure, BookingConfirmation>> call(String bookingId) async {
    return await repository.getBookingConfirmation(bookingId);
  }
}
