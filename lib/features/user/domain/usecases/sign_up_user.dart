import 'package:dartz/dartz.dart';
import 'user_entity.dart';
import 'failure.dart';
import 'user_repository.dart';

// 1. Sign Up User
class SignUpUser {
  final UserRepository repository;

  SignUpUser(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) {
    return repository.signUp(
      name: name,
      email: email,
      password: password,
      role: role,
    );
  }
}
