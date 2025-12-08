// ./scripts/seed_booking_confirmation.dart
import 'package:attendly/features/booking_confirmation/data/datasources/firebase/firebase_booking_confirmation_data_source.dart';
import 'package:attendly/features/booking_confirmation/data/models/booking_confirmation_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendly/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final confirmationDataSource = FirebaseBookingConfirmationDataSource();

  // 👉 You must replace these with real booking IDs after running seed_bookings.dart
  // For now, we simulate using placeholder IDs and current time
  const String BOOKING_ID_1 = 'BOOKING_ID_1';
  const String BOOKING_ID_2 = 'BOOKING_ID_2';
  const String CLIENT_ID_1 = 'CLIENT_ID_1';
  const String PROFESSIONAL_ID_1 = 'PROFESSIONAL_ID_1';
  const String PROFESSIONAL_ID_2 = 'PROFESSIONAL_ID_2';

  final List<Map<String, dynamic>> sampleConfirmations = [
    {
      'bookingId': BOOKING_ID_1,
      'clientId': CLIENT_ID_1,
      'professionalId': PROFESSIONAL_ID_1,
      'confirmedAt': DateTime.now(),
      'isConfirmed': true,
    },
    {
      'bookingId': BOOKING_ID_2,
      'clientId': CLIENT_ID_1,
      'professionalId': PROFESSIONAL_ID_2,
      'confirmedAt': DateTime.now().subtract(const Duration(minutes: 30)),
      'isConfirmed': true,
    },
  ];

  for (final confirmData in sampleConfirmations) {
    try {
      print('Creating confirmation for booking: ${confirmData['bookingId']}');
      final confirmation = BookingConfirmationModel(
        bookingId: confirmData['bookingId'] as String,
        clientId: confirmData['clientId'] as String,
        professionalId: confirmData['professionalId'] as String,
        confirmedAt: confirmData['confirmedAt'] as DateTime,
        isConfirmed: confirmData['isConfirmed'] as bool,
      );
      await confirmationDataSource.setBookingConfirmation(confirmation);
      print(
          '✅ Successfully created booking confirmation for booking: ${confirmData['bookingId']}');
    } catch (e) {
      print(
          '❌ Error creating confirmation for booking ${confirmData['bookingId']}: $e');
    }
  }

  print('🏁 Booking confirmation seeding completed.');
}
