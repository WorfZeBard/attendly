import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    super.phone,
  });

  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser,
      {UserRole? role}) {
    return UserModel(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      phone: firebaseUser.phoneNumber,
      role: role ?? UserRole.client,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: UserRole.values.firstWhere(
        (r) => r.toString() == 'UserRole.${json['role']}',
        orElse: () => UserRole.client,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role.name,
      };
}
