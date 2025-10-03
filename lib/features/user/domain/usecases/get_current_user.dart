import 'package:dartz/dartz.dart';
import 'user_entity.dart';
import 'package:dartz/dartz.dart';
import 'user_entity.dart';
import 'failure.dart';
import 'user_repository.dart';

// 3. Get Current User
class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.getCurrentUser();
  }
}
