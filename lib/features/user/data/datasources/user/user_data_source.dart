import '../../../domain/entities/user.dart';
import '../../models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> signUpUser({
    required String name,
    required String email,
    required String password,
    String? phone,
    required UserRole role,
  });

  Future<UserModel> loginUser({
    required String email,
    required String password,
  });

  Future<UserModel> getCurrentUser();

  Future<void> logoutUser();
}