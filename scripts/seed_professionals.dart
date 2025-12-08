// scripts/seed_professionals.dart
import 'package:attendly/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;
  final professionalsRef = firestore.collection('professionals');

  final professionalData = {
    'id': 'prof_123',
    'businessName': 'Stylish Cuts',
    'logoUrl': 'https://example.com/logo.png',
  };

  await professionalsRef.doc('prof_123').set(professionalData);
  print('✅ Seeded professional: prof_123');
}
