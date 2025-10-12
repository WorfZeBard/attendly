import 'package:firebase_auth/firebase_auth.dart';
import '../../../../models/user_model.dart';
import 'user_data_source.dart';

class FirebaseUserDataSource implements UserDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseUserDataSource({required this.firebaseAuth});

  @override
  Future<UserModel> signUpUser({
    required String name,
    required String email,
    required String password,
    String? phone,
    required UserRole role,
  }) async {
    final UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    await userCredential.user?.updateDisplayName(name);
    return UserModel.fromFirebaseUser(userCredential);
  }

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseUser(userCredential);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw const FirebaseAuthException(code: 'no-user');
    }
    return UserModel.fromFirebaseUser(UserCredential(
      user: currentUser,
      credential: null,
    ));
  }

  @override
  Future<void> logoutUser() async {
    await firebaseAuth.signOut();
  }
}