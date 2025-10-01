// repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUpUser({
    required String name,
    required String email,
    required String password,
    String? phone,
    required UserRole role,
  });

  Future<Either<Failure, User>> loginUser({
    required String email,
    required String password,
  });
}
