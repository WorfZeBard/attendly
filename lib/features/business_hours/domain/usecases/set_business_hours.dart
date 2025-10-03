// usecases/set_business_hours.dart
import 'package:dartz/dartz.dart';
import '../entities/business_hours.dart';
import '../repositories/business_hours_repository.dart';
import '../../../core/error/failures.dart';

class SetBusinessHours {
  final BusinessHoursRepository repository;

  SetBusinessHours(this.repository);

  Future<Either<Failure, BusinessHours>> call(BusinessHours hours) async {
    return await repository.setBusinessHours(hours);
  }
}


