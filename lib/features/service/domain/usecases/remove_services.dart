// usecases/remove_service.dart
import 'package:dartz/dartz.dart';
import '../../../user/domain/failures/failure.dart';
import '../repositories/service_repository.dart';

class RemoveService {
  final ServiceRepository repository;

  RemoveService(this.repository);

  Future<Either<Failure, void>> call(String serviceId) async {
    return await repository.removeService(serviceId);
  }
}


