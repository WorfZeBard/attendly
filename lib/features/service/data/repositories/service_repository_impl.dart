import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/repositories/service_repository.dart';
import '../../datasources/service_data_source.dart';
import '../../models/service_model.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceDataSource dataSource;

  ServiceRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Service>> addService(Service service) async {
    try {
      final serviceModel = ServiceModel.fromEntity(service);
      final result = await dataSource.addService(serviceModel);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Service>>> getServices(String professionalId) async {
    try {
      final result = await dataSource.getServices(professionalId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeService(String serviceId) async {
    try {
      await dataSource.removeService(serviceId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}