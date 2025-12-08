// ./scripts/seed_booking_confirmation.dart
import 'package:attendly/features/booking_confirmation/data/datasources/firebase/firebase_booking_confirmation_data_source.dart';
import 'package:attendly/features/booking_confirmation/data/models/booking_confirmation_model.dart';
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
  final confirmationDataSource = FirebaseBookingConfirmationDataSource();

  // 👉 You must replace these with real booking IDs after running seed_bookings.dart
  // For now, we simulate using placeholder IDs and current time
  const String bookingId1 = 'BOOKING_ID_1';
  const String bookingId2 = 'BOOKING_ID_2';
  const String clientId1 = 'CLIENT_ID_1';
  const String professionalId1 = 'PROFESSIONAL_ID_1';
  const String professionalId2 = 'PROFESSIONAL_ID_2';

  final List<Map<String, dynamic>> sampleConfirmations = [
    {
      'bookingId': bookingId1,
      'clientId': clientId1,
      'professionalId': professionalId1,
      'confirmedAt': DateTime.now(),
      'isConfirmed': true,
    },
    {
      'bookingId': bookingId2,
      'clientId': clientId1,
      'professionalId': professionalId2,
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
