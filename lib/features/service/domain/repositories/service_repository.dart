// repositories/service_repository.dart
import 'package:dartz/dartz.dart';
import '../../../user/domain/failures/failure.dart';
import '../entities/service.dart';

abstract class ServiceRepository {
  Future<Either<Failure, Service>> addService(Service service);
  Future<Either<Failure, List<Service>>> getServices(String professionalId);
  Future<Either<Failure, void>> removeService(String serviceId);
}


