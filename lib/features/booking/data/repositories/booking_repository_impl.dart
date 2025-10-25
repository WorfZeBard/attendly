import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/entities/booking.dart';
import '../datasources/booking_data_source.dart';
import '../models/booking_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDataSource dataSource;

  BookingRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Booking>> createBooking(Booking booking) async {
    try {
      final BookingModel bookingModel = 
          BookingModel.fromEntity(booking as BookingModel);
      
      final BookingModel result = 
          await dataSource.createBookingModel(bookingModel);
      
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Authentication failed'));
    } on FirebaseException catch (e) {
      return Left(ServerFailure('Firestore error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getBookings(
      String professionalId) async {
    try {
      final List<BookingModel> result = 
          await dataSource.getBookingsByProfessionalId(professionalId);
      
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Authentication failed'));
    } on FirebaseException catch (e) {
      return Left(ServerFailure('Firestore error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}