// ./scripts/seed_bookings.dart
import 'package:attendly/features/booking/data/datasources/firebase/firebase_booking_data_source.dart';
import 'package:attendly/features/booking/data/models/booking_model.dart';
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

  // 👉 Authenticate as the client to satisfy 'createdById'
  try {
    await auth.signInWithEmailAndPassword(
      email: 'uat_client1@example.com',
      password: 'TempPass123!',
    );
    print('🔑 Authenticated as client for booking creation');
  } catch (e) {
    print(
        '⚠️ Failed to authenticate client. Booking may fail due to security rules.');
  }

  final bookingDataSource = FirebaseBookingDataSource(firebaseAuth: auth);

  // 👉 REPLACE with real IDs from seed_users.dart
  const String clientId1 = 'CLIENT_ID_1';
  const String professionalId1 = 'PROFESSIONAL_ID_1';
  const String professionalId2 = 'PROFESSIONAL_ID_2';

  final List<Map<String, dynamic>> sampleBookings = [
    {
      'clientId': clientId1,
      'professionalId': professionalId1,
      'dateTime': DateTime.now().add(const Duration(days: 1, hours: 10)),
    },
    {
      'clientId': clientId1,
      'professionalId': professionalId2,
      'dateTime': DateTime.now().add(const Duration(days: 2, hours: 15)),
    },
  ];

  for (final bookingData in sampleBookings) {
    try {
      print(
          'Creating booking for client ${bookingData['clientId']} with professional ${bookingData['professionalId']}');
      final booking = BookingModel(
        id: '',
        clientId: bookingData['clientId'] as String,
        professionalId: bookingData['professionalId'] as String,
        dateTime: bookingData['dateTime'] as DateTime,
      );
      await bookingDataSource.createBookingModel(booking);
      print(
          '✅ Successfully created booking for professional: ${bookingData['professionalId']}');
    } catch (e) {
      print(
          '❌ Error creating booking for professional ${bookingData['professionalId']}: $e');
    }
  }

  print('🏁 Booking seeding completed.');
}
