import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../domain/repositories/booking_confirmation_repository.dart';
import '../../datasources/booking_confirmation_data_source.dart';
import '../../models/booking_confirmation_model.dart';

class BookingConfirmationRepositoryImpl
    implements BookingConfirmationRepository {
  final BookingConfirmationDataSource dataSource;

  BookingConfirmationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BookingConfirmationModel>> getBookingConfirmation(
      String bookingId) async {
    try {
      final result = await dataSource.getBookingConfirmation(bookingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingConfirmationModel>> setBookingConfirmation(
      BookingConfirmationModel confirmation) async {
    try {
      final result = await dataSource.setBookingConfirmation(confirmation);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}