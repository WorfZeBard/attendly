// usecases/sign_up_user.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class SignUpUser {
  final UserRepository repository;

  SignUpUser(this.repository);

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
    String? phone,
    required UserRole role,
  }) async {
    return await repository.signUpUser(
      name: name,
      email: email,
      password: password,
      phone: phone,
      role: role,
    );
  }
}
