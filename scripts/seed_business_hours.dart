// scripts/seed_business_hours.dart
import 'package:attendly/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;

  final businessHoursRef = firestore.collection('business_hours');

  final hoursData = {
    'professionalId': 'prof_123',
    'workingDays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    'startTime': '09:00',
    'endTime': '18:00',
    'breaks': [
      {'start': '12:00', 'end': '13:00'}
    ],
  };

  await businessHoursRef.doc('prof_123').set(hoursData);
  print('✅ Seeded business hours for prof_123.');
}
