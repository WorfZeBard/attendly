// lib/presentation/user/state/user_state.dart

import 'package:attendly/features/user/domain/entities/user.dart';

class UserState {
  final User? user;
  final bool isLoading;
  final String errorMessage;

  UserState({
    required this.user,
    required this.isLoading,
    required this.errorMessage,
  });

  factory UserState.initial() {
    return UserState(user: null, isLoading: false, errorMessage: '');
  }

  UserState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
