// scripts/seed_users.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendly/firebase_options.dart';

void main() async {
  // No WidgetsFlutterBinding here — this is not a UI Flutter app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> sampleUsers = [
    {
      'name': 'UAT Client 1',
      'email': 'uat_client1@example.com',
      'password': 'TempPass123!',
      'phone': '+12345678901',
      'role': 'client',
    },
    {
      'name': 'UAT Professional 1',
      'email': 'uat_prof1@example.com',
      'password': 'TempPass123!',
      'phone': '+12345678902',
      'role': 'professional',
    },
    {
      'name': 'UAT Professional 2',
      'email': 'uat_prof2@example.com',
      'password': 'TempPass123!',
      'phone': '+12345678903',
      'role': 'professional',
    },
  ];

  for (final userData in sampleUsers) {
    try {
      print('Creating user: ${userData['email']}');

      final credential = await auth.createUserWithEmailAndPassword(
        email: userData['email']!,
        password: userData['password']!,
      );

      await firestore.collection('users').doc(credential.user!.uid).set({
        'name': userData['name'],
        'email': userData['email'],
        'phone': userData['phone'],
        'role': userData['role'],
        'createdBy': 'uat-seed-script',
      });

      print('Successfully created user: ${userData['email']}');
    } catch (e) {
      print('Error creating user ${userData['email']}: $e');
    }
  }

  print('User seeding completed.');
}
