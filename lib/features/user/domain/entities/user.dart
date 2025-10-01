// entities/user.dart
import 'package:equatable/equatable.dart';

enum UserRole { client, professional }

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final UserRole role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, email, phone, role];
}
