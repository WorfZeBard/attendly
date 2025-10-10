import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

// 3. Get Current User
class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.getCurrentUser();
  }
}
