import '../../../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toString().split('.').last
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'] == 'client' ? UserRole.client : UserRole.professional,
    );
  }

  factory UserModel.fromFirebaseUser(UserCredential firebaseUser) {
    return UserModel(
      id: firebaseUser.user!.uid,
      name: firebaseUser.user!.displayName ?? '',
      email: firebaseUser.user!.email!,
      phone: firebaseUser.user!.phoneNumber,
      role: UserRole.client, // Default role
    );
  }

  factory UserModel.fromUser(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      role: user.role,
    );
  }
}