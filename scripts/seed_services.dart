// scripts/seed_services.dart
import 'package:attendly/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final docRef = await FirebaseFirestore.instance.collection('services').add({
    'id': '',
    'professionalId': 'prof_123',
    'name': 'Haircut',
    'durationMinutes': 45,
    'price': 50.0,
  });

  // Update with real ID
  await docRef.update({'id': docRef.id});

  print('✅ Seeded service with ID: ${docRef.id}');
}
