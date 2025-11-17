// scripts/seed_business_hours.dart
import 'package:attendly/features/business_hours/data/datasources/firebase/business_hours_firestore.dart';
import 'package:attendly/features/business_hours/data/models/business_hours_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendly/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // IMPORTANT: This script requires an authenticated user context.
  // For UAT seeding, you might need to authenticate as the professional
  // whose business hours you are setting, or use an admin account with
  // appropriate permissions if your security rules allow it.
  // This example assumes a default (potentially unauthenticated) context
  // which might fail depending on your Firestore rules.
  // You might need to sign in as the specific user first or use Admin SDK.
  final auth = FirebaseAuth.instance;

  // Example: Sign in as a specific user (replace with actual credentials)
  // try {
  //   await auth.signInWithEmailAndPassword(
  //     email: 'uat_prof1@example.com',
  //     password: 'TempPass123!',
  //   );
  // } catch (e) {
  //   print("Error signing in for business hours seeding: $e");
  //   return; // Exit if authentication fails
  // }

  final businessHoursDataSource =
      BusinessHoursFirestoreDataSource(firebaseAuth: auth);

  // Sample Business Hours Data for UAT - Associate with known professional IDs
  final List<Map<String, dynamic>> sampleBusinessHours = [
    {
      'professionalId':
          'PROFESSIONAL_ID_1', // Replace with actual seeded professional ID
      'workingDays': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      'startTime': '09:00',
      'endTime': '17:00',
      'breaks': [
        {'start': '12:00', 'end': '13:00'}
      ],
    },
    {
      'professionalId': 'PROFESSIONAL_ID_2',
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
        breaks: List<Map<String, String>>.from((hoursData['breaks'] as List)
            .map((b) => Map<String, String>.from(b))),
      );

      await businessHoursDataSource.setBusinessHours(businessHours);
      print(
          'Successfully set business hours for professional: ${hoursData['professionalId']}');
    } catch (e) {
      print(
          'Error setting business hours for ${hoursData['professionalId']}: $e');
    }
  }

  print('Business hours seeding completed.');
}
