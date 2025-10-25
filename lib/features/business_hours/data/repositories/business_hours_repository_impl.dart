import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/business_hours_repository.dart';
import '../../domain/entities/business_hours.dart';
import '../datasources/firebase/business_hours_firestore.dart';
import '../models/business_hours_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BusinessHoursRepositoryImpl implements BusinessHoursRepository {
  final BusinessHoursFirestoreDataSource firestoreDataSource;

  BusinessHoursRepositoryImpl({required this.firestoreDataSource});

  @override
  Future<Either<Failure, BusinessHours>> setBusinessHours(
      BusinessHours hours) async {
    try {
      final BusinessHoursModel model =
          BusinessHoursModel.fromEntity(hours as BusinessHoursModel);
      final result = await firestoreDataSource.setBusinessHours(model);
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
  Future<Either<Failure, BusinessHours>> getBusinessHours(
      String professionalId) async {
    try {
      final result = await firestoreDataSource.getBusinessHours(professionalId);
      return Right(result);
    } on FirebaseAuthException catch (_) {
      return Left(const AuthFailure('Authentication error'));
    } on FirebaseException catch (e) {
      return Left(ServerFailure('Firestore error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}