// ./scripts/seed_users.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// ✅ Hardcode Firebase options (use your web config from firebase_options.dart)
final FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyDlgiogIv8a4104nT8pHOhejGJXcuAL44E",
  authDomain: "attendly-dd63f.firebaseapp.com",
  projectId: "attendly-dd63f",
  storageBucket: "attendly-dd63f.firebasestorage.app",
  messagingSenderId: "1099496840630",
  appId: "1:1099496840630:web:577b8d77949d19b160f517",
  measurementId: "G-N46G08LV8P",
);

void main() async {
  await Firebase.initializeApp(options: firebaseOptions);

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
        email: userData['email'] as String,
        password: userData['password'] as String,
      );
      await firestore.collection('users').doc(credential.user!.uid).set({
        'name': userData['name'],
        'email': userData['email'],
        'phone': userData['phone'],
        'role': userData['role'],
        'createdBy': 'uat-seed-script',
      });
      print(
          '✅ Successfully created user: ${userData['email']} (UID: ${credential.user!.uid})');
    } catch (e) {
      print('❌ Error creating user ${userData['email']}: $e');
    }
  }

  print('🏁 User seeding completed.');
}
