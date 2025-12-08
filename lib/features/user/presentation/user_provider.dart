// lib/features/user/presentation/user_provider.dart
import 'package:attendly/features/user/domain/entities/user.dart';
import 'package:attendly/features/user/domain/usecases/get_current_user.dart';
import 'package:attendly/features/user/domain/usecases/get_current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ✅ This must expose StateNotifier

import 'user_state.dart';

// This class is CORRECT — but only if StateNotifier is a real class
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this._getCurrentUser) : super(UserState.initial());

  final GetCurrentUser _getCurrentUser;

  Future<void> loadUser() async {
    state = state.copyWith(
        isLoading: true); // ✅ 'state' is a protected field in StateNotifier

    final result = await _getCurrentUser();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          user: user,
          errorMessage: '',
        );
      },
    );
  }

  void updateUser(User updatedUser) {
    state = state.copyWith(user: updatedUser);
  }
}

// ✅ Ensure StateNotifierProvider is available
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final usecase = ref.read(getCurrentUserProvider);
  return UserNotifier(usecase);
});
