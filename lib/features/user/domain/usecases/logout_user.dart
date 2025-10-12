import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

// 4. Logout User
class LogoutUser {
  final UserRepository repository;

  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logoutUser();
  }
}
