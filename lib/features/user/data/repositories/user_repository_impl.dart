import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/entities/user.dart';
import '../../datasources/user/user_data_source.dart';
import '../../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, User>> signUpUser({
    required String name,
    required String email,
    required String password,
    String? phone,
    required UserRole role,
  }) async {
    try {
      final UserModel userModel = await dataSource.signUpUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        role: role,
      );
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Sign up failed'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserModel userModel = await dataSource.loginUser(
        email: email,
        password: password,
      );
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Login failed'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final UserModel userModel = await dataSource.getCurrentUser();
      return Right(userModel);
    } on FirebaseAuthException catch (_) {
      return Left(const AuthFailure('No user logged in'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      await dataSource.logoutUser();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Logout failed'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}