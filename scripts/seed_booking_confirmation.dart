// scripts/seed_booking_confirmations.dart
import 'package:attendly/features/booking_confirmation/data/datasources/firebase/firebase_booking_confirmation_data_source.dart';
import 'package:attendly/features/booking_confirmation/data/models/booking_confirmation_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendly/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final confirmationDataSource = FirebaseBookingConfirmationDataSource();

  // Sample Booking Confirmation Data for UAT - Use known Booking, Client, and Professional IDs
  final List<Map<String, dynamic>> sampleConfirmations = [
    {
      'bookingId': 'BOOKING_ID_1', // Replace with actual seeded booking ID
      'clientId': 'CLIENT_ID_1', // Replace with corresponding client ID
      'professionalId':
          'PROFESSIONAL_ID_1', // Replace with corresponding professional ID
      'confirmedAt': DateTime.now(), // Current timestamp
      'isConfirmed': true, // Or false for declined
    },
    {
      'bookingId': 'BOOKING_ID_2',
      'clientId': 'CLIENT_ID_1',
      'professionalId': 'PROFESSIONAL_ID_2',
      'confirmedAt':
          DateTime.now().subtract(Duration(minutes: 30)), // 30 mins ago
      'isConfirmed': true,
    },
  ];

  for (final confirmData in sampleConfirmations) {
    try {
      print(
          'Creating booking confirmation for booking: ${confirmData['bookingId']}');
      final confirmation = BookingConfirmationModel(
        bookingId: confirmData['bookingId'] as String,
        clientId: confirmData['clientId'] as String,
        professionalId: confirmData['professionalId'] as String,
        confirmedAt: confirmData['confirmedAt'] as DateTime,
        isConfirmed: confirmData['isConfirmed'] as bool,
      );

      await confirmationDataSource.setBookingConfirmation(confirmation);
      print(
          'Successfully created booking confirmation for booking: ${confirmData['bookingId']}');
    } catch (e) {
      print(
          'Error creating booking confirmation for booking ${confirmData['bookingId']}: $e');
    }
  }

  print('Booking confirmation seeding completed.');
}
