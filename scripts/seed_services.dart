// ./scripts/seed_services.dart
import 'package:attendly/features/service/data/datasources/firebase/firebase_service_data_source.dart';
import 'package:attendly/features/service/data/models/service_model.dart';
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

  final serviceDataSource = FirebaseServiceDataSource();

  // 👉 REPLACE THESE PLACEHOLDERS with real professional UIDs from seed_users.dart
  const String professionalId1 = 'PROFESSIONAL_ID_1'; // e.g. 'abc123'
  const String professionalId2 = 'PROFESSIONAL_ID_2'; // e.g. 'def456'

  final List<Map<String, dynamic>> sampleServices = [
    {
      'professionalId': professionalId1,
      'name': 'Haircut',
      'durationMinutes': 30,
      'price': 25.0,
    },
    {
      'professionalId': professionalId1,
      'name': 'Haircut & Beard Trim',
      'durationMinutes': 45,
      'price': 40.0,
    },
    {
      'professionalId': professionalId2,
      'name': 'Basic Massage',
      'durationMinutes': 60,
      'price': 60.0,
    },
    {
      'professionalId': professionalId2,
      'name': 'Deep Tissue Massage',
      'durationMinutes': 90,
      'price': 90.0,
    },
  ];

  for (final serviceData in sampleServices) {
    try {
      print(
          'Creating service: ${serviceData['name']} for professional ${serviceData['professionalId']}');
      final service = ServiceModel(
        id: '',
        professionalId: serviceData['professionalId'] as String,
        name: serviceData['name'] as String,
        durationMinutes: serviceData['durationMinutes'] as int,
        price: serviceData['price'] as double,
      );
      await serviceDataSource.addService(service);
      print('✅ Successfully created service: ${serviceData['name']}');
    } catch (e) {
      print('❌ Error creating service ${serviceData['name']}: $e');
    }
  }

  print('🏁 Service seeding completed.');
}
