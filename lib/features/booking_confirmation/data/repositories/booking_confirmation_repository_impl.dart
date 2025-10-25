import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/booking_confirmation.dart';
import '../../domain/repositories/booking_confirmation_repository.dart';
import '../datasources/booking_confirmation_data_source.dart';
import '../models/booking_confirmation_model.dart';

class BookingConfirmationRepositoryImpl
    implements BookingConfirmationRepository {
  final BookingConfirmationDataSource dataSource;

  BookingConfirmationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BookingConfirmation>> getBookingConfirmation(
      String bookingId) async {
    try {
      final result = await dataSource.getBookingConfirmation(bookingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingConfirmation>> confirmBooking({
    required String bookingId,
    required String clientId,
    required String professionalId,
    required DateTime confirmedAt,
  }) async {
    try {
      final model = BookingConfirmationModel(
        bookingId: bookingId,
        clientId: clientId,
        professionalId: professionalId,
        confirmedAt: confirmedAt,
        isConfirmed: true,
      );

      final result = await dataSource.setBookingConfirmation(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
