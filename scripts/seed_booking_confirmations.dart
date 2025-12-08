// scripts/seed_booking_confirmations.dart
import 'package:attendly/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;

  final confirmationsRef = firestore.collection('bookingConfirmations');

  final confirmationData = {
    'bookingId': 'booking_987',
    'clientId': 'client_456',
    'professionalId': 'prof_123',
    'confirmedAt': DateTime.now().toIso8601String(),
    'isConfirmed': true,
  };

  await confirmationsRef.doc('booking_987').set(confirmationData);
  print('✅ Seeded one booking confirmation.');
}
