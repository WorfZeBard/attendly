// repositories/business_hours_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/business_hours.dart';
import '../../../core/error/failures.dart';

abstract class BusinessHoursRepository {
  Future<Either<Failure, BusinessHours>> setBusinessHours(BusinessHours hours);
  Future<Either<Failure, BusinessHours>> getBusinessHours(String professionalId);
}
