// scripts/seed_clients.dart
import 'package:attendly/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;
  final clientsRef = firestore.collection('clients');

  final clientData = {
    'id': 'client_456',
    'name': 'Alex Client',
    'email': 'test.client@example.com',
    'phone': '+1234567890',
    'role': 'client',
  };

  await clientsRef.doc('client_456').set(clientData);
  print('✅ Seeded client: client_456');
}
