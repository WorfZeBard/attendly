import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../domain/entities/user.dart' as domain;
import '../../models/user_model.dart';
import 'user_data_source.dart';

class FirebaseUserDataSource implements UserDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  FirebaseUserDataSource({required this.firebaseAuth});

  @override
  Future<UserModel> signUpUser({
    required String name,
    required String email,
    required String password,
    String? phone,
    required domain.UserRole role,
  }) async {
    final firebase_auth.UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredential.user?.updateDisplayName(name);
    final firebase_auth.User? user = userCredential.user;

    if (user == null) {
      throw firebase_auth.FirebaseAuthException(code: 'user-null');
    }

    return UserModel.fromFirebaseUser(user, role: role);
  }

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    final firebase_auth.UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebase_auth.User? user = userCredential.user;
    if (user == null) {
      throw firebase_auth.FirebaseAuthException(code: 'user-null');
    }

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final firebase_auth.User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw firebase_auth.FirebaseAuthException(code: 'no-user');
    }

    return UserModel.fromFirebaseUser(currentUser);
  }

  @override
  Future<void> logoutUser() async {
    await firebaseAuth.signOut();
  }
}
