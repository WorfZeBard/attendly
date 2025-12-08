// ./scripts/seed_business_hours.dart
import 'package:attendly/features/business_hours/data/datasources/firebase/business_hours_firestore.dart';
import 'package:attendly/features/business_hours/data/models/business_hours_model.dart';
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

  // 👉 UNCOMMENT & UPDATE if your Firestore rules require auth
  try {
    await auth.signInWithEmailAndPassword(
      email: 'uat_prof1@example.com',
      password: 'TempPass123!',
    );
    print('🔑 Authenticated as uat_prof1@example.com');
  } catch (e) {
    print(
        '⚠️ Warning: Could not authenticate. Seeding may fail due to security rules.');
    // Continue anyway — may work if rules allow writes from admin-like context
  }

  final businessHoursDataSource =
      BusinessHoursFirestoreDataSource(firebaseAuth: auth);

  // 👉 REPLACE THESE with real professional UIDs
  const String professionalId1 = 'PROFESSIONAL_ID_1';
  const String professionalId2 = 'PROFESSIONAL_ID_2';

  final List<Map<String, dynamic>> sampleBusinessHours = [
    {
      'professionalId': professionalId1,
      'workingDays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'startTime': '09:00',
      'endTime': '17:00',
      'breaks': [
        {'start': '12:00', 'end': '13:00'}
      ],
    },
    {
      'professionalId': professionalId2,
      'workingDays': ['Tue', 'Wed', 'Thu', 'Sat'],
      'startTime': '10:00',
      'endTime': '19:00',
      'breaks': [
        {'start': '14:30', 'end': '15:00'},
        {'start': '17:00', 'end': '17:30'}
      ],
    },
  ];

  for (final hoursData in sampleBusinessHours) {
    try {
      print(
          'Setting business hours for professional: ${hoursData['professionalId']}');
      final businessHours = BusinessHoursModel(
        professionalId: hoursData['professionalId'] as String,
        workingDays: List<String>.from(hoursData['workingDays'] as List),
        startTime: hoursData['startTime'] as String,
        endTime: hoursData['endTime'] as String,
        breaks: List<Map<String, String>>.from(
          (hoursData['breaks'] as List).map((b) => Map<String, String>.from(b)),
        ),
      );
      await businessHoursDataSource.setBusinessHours(businessHours);
      print(
          '✅ Successfully set business hours for professional: ${hoursData['professionalId']}');
    } catch (e) {
      print(
          '❌ Error setting business hours for ${hoursData['professionalId']}: $e');
    }
  }

  print('🏁 Business hours seeding completed.');
}
