// repositories/booking_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/booking.dart';
import '../../../../core/error/failures.dart';

abstract class BookingRepository {
  Future<Either<Failure, Booking>> createBooking(Booking booking);
  Future<Either<Failure, List<Booking>>> getBookings(String professionalId);
}


