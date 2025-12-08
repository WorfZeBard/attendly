// ./scripts/seed_bookings.dart
import 'package:attendly/features/booking/data/datasources/firebase/firebase_booking_data_source.dart';
import 'package:attendly/features/booking/data/models/booking_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendly/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  const String CLIENT_ID_1 = 'CLIENT_ID_1';
  const String PROFESSIONAL_ID_1 = 'PROFESSIONAL_ID_1';
  const String PROFESSIONAL_ID_2 = 'PROFESSIONAL_ID_2';

  final List<Map<String, dynamic>> sampleBookings = [
    {
      'clientId': CLIENT_ID_1,
      'professionalId': PROFESSIONAL_ID_1,
      'dateTime': DateTime.now().add(const Duration(days: 1, hours: 10)),
    },
    {
      'clientId': CLIENT_ID_1,
      'professionalId': PROFESSIONAL_ID_2,
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
