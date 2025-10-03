// usecases/get_services.dart
import 'package:dartz/dartz.dart';
import '../../../user/domain/failures/failure.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class GetServices {
  final ServiceRepository repository;

  GetServices(this.repository);

  Future<Either<Failure, List<Service>>> call(String professionalId) async {
    return await repository.getServices(professionalId);
  }
}


