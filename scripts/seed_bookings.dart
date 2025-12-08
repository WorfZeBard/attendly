// scripts/seed_bookings.dart (updated version)
import 'package:attendly/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // Sign in as existing test client
  UserCredential userCredential;
  try {
    userCredential = await auth.signInWithEmailAndPassword(
      email: 'test.client@example.com',
      password: 'password123',
    );
    print('Signed in as client: ${userCredential.user!.uid}');
  } catch (e) {
    print('⚠️ Could not sign in client: $e');
    return;
  }

  final userId = userCredential.user!.uid;
  final bookingsRef = firestore.collection('bookings');

  final bookingData = {
    'id': 'booking_987',
    'clientId': 'client_456', // or userId if you store UID directly
    'professionalId': 'prof_123',
    'dateTime': DateTime(2025, 12, 10, 15, 30).toIso8601String(),
    'createdById': userId,
    'createdOn': FieldValue.serverTimestamp(),
    'status': 'pending',
  };

  await bookingsRef.doc('booking_987').set(bookingData);
  print('✅ Seeded booking: booking_987');
}
