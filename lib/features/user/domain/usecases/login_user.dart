import 'package:dartz/dartz.dart';
import 'user_entity.dart';
import 'failure.dart';
import 'user_repository.dart';

// 2. Login User
class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
