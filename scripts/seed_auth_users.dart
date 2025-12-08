// scripts/seed_auth_users.dart
import 'package:attendly/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final auth = FirebaseAuth.instance;

  try {
    await auth.createUserWithEmailAndPassword(
      email: 'test.professional@example.com',
      password: 'password123',
    );
    print('✅ Created test professional user.');
  } catch (e) {
    print('⚠️ User may already exist: $e');
  }

  try {
    await auth.createUserWithEmailAndPassword(
      email: 'test.client@example.com',
      password: 'password123',
    );
    print('✅ Created test client user.');
  } catch (e) {
    print('⚠️ User may already exist: $e');
  }
}
