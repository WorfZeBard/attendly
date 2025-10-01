// usecases/create_booking.dart
import 'package:dartz/dartz.dart';
import '../entities/booking.dart';
import '../repositories/booking_repository.dart';
import '../../../core/error/failures.dart';

class CreateBooking {
  final BookingRepository repository;

  CreateBooking(this.repository);

  Future<Either<Failure, Booking>> call(Booking booking) async {
    return await repository.createBooking(booking);
  }
}
