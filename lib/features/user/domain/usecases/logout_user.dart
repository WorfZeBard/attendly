import 'package:dartz/dartz.dart';
import 'user_entity.dart';
import 'failure.dart';
import 'user_repository.dart';

// 4. Logout User
class LogoutUser {
  final UserRepository repository;

  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
