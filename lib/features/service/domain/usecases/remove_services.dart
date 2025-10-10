// usecases/remove_service.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/service_repository.dart';

class RemoveService {
  final ServiceRepository repository;

  RemoveService(this.repository);

  Future<Either<Failure, void>> call(String serviceId) async {
    return await repository.removeService(serviceId);
  }
}


