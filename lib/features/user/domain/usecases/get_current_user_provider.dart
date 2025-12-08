import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:attendly/features/user/domain/usecases/get_current_user.dart';
import 'package:attendly/features/user/data/repositories/user_repository_impl.dart';
import 'package:attendly/features/user/data/datasources/user/firebase_user_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

final getCurrentUserProvider = Provider<GetCurrentUser>((ref) {
  final dataSource =
      FirebaseUserDataSource(firebaseAuth: FirebaseAuth.instance);
  final repository = UserRepositoryImpl(dataSource: dataSource);
  return GetCurrentUser(repository);
});
