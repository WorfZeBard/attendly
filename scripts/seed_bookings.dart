// scripts/seed_bookings.dart
import 'package:attendly/features/booking/data/datasources/firebase/firebase_booking_data_source.dart';
import 'package:attendly/features/booking/data/models/booking_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendly/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // IMPORTANT: This script requires an authenticated user context.
  // The 'createdById' will be set to the currently authenticated user's ID.
  // For UAT seeding, you might need to authenticate as a specific user
  // (e.g., an admin or the client making the booking) or use an admin account
  // if your security rules permit it.
  // This example assumes a default (potentially unauthenticated) context
  // which might fail depending on your Firestore rules.
  // You might need to sign in as the specific user first or use Admin SDK.
  final auth = FirebaseAuth.instance;

  // Example: Sign in as a client user (replace with actual credentials)
  // try {
  //   await auth.signInWithEmailAndPassword(
  //     email: 'uat_client1@example.com',
  //     password: 'TempPass123!',
  //   );
  // } catch (e) {
  //   print("Error signing in for booking seeding: $e");
  //   return; // Exit if authentication fails
  // }

  final bookingDataSource = FirebaseBookingDataSource(firebaseAuth: auth);

  // Sample Booking Data for UAT - Use known Client and Professional IDs
  final List<Map<String, dynamic>> sampleBookings = [
    {
      'clientId': 'CLIENT_ID_1', // Replace with actual seeded client ID
      'professionalId':
          'PROFESSIONAL_ID_1', // Replace with actual seeded professional ID
      'dateTime':
          DateTime.now().add(Duration(days: 1, hours: 10)), // Tomorrow at 10 AM
    },
    {
      'clientId': 'CLIENT_ID_1',
      'professionalId': 'PROFESSIONAL_ID_2',
      'dateTime': DateTime.now()
          .add(Duration(days: 2, hours: 15)), // Day after tomorrow at 3 PM
    },
    {
      'clientId': 'ANOTHER_CLIENT_ID', // Replace with another seeded client ID
      'professionalId': 'PROFESSIONAL_ID_1',
      'dateTime': DateTime.now()
          .add(Duration(days: 3, hours: 11)), // In 3 days at 11 AM
    },
  ];

  for (final bookingData in sampleBookings) {
    try {
      print(
          'Creating booking for client ${bookingData['clientId']} with professional ${bookingData['professionalId']} at ${bookingData['dateTime']}');
      final booking = BookingModel(
        id: '', // Firestore will auto-generate
        clientId: bookingData['clientId'] as String,
        professionalId: bookingData['professionalId'] as String,
        dateTime: bookingData['dateTime'] as DateTime,
      );

      await bookingDataSource.createBookingModel(booking);
      print(
          'Successfully created booking for professional: ${bookingData['professionalId']}');
    } catch (e) {
      print(
          'Error creating booking for professional ${bookingData['professionalId']}: $e');
    }
  }

  print('Booking seeding completed.');
}
