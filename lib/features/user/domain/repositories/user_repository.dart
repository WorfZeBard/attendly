// repositories/user_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';

abstract class UserRepository {
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

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> logoutUser();
}
