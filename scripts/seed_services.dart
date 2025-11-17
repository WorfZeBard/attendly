// scripts/seed_services.dart
import 'package:attendly/features/service/data/datasources/firebase/firebase_service_data_source.dart';
import 'package:attendly/features/service/data/models/service_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attendly/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final serviceDataSource = FirebaseServiceDataSource();

  // Sample Service Data for UAT - Associate with known professional IDs
  final List<Map<String, dynamic>> sampleServices = [
    {
      'professionalId':
          'PROFESSIONAL_ID_1', // Replace with actual seeded professional ID
      'name': 'Haircut',
      'durationMinutes': 30,
      'price': 25.0,
    },
    {
      'professionalId': 'PROFESSIONAL_ID_1',
      'name': 'Haircut & Beard Trim',
      'durationMinutes': 45,
      'price': 40.0,
    },
    {
      'professionalId': 'PROFESSIONAL_ID_2',
      'name': 'Basic Massage',
      'durationMinutes': 60,
      'price': 60.0,
    },
    {
      'professionalId': 'PROFESSIONAL_ID_2',
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
        id: '', // Firestore will auto-generate
        professionalId: serviceData['professionalId'] as String,
        name: serviceData['name'] as String,
        durationMinutes: serviceData['durationMinutes'] as int,
        price: serviceData['price'] as double,
      );

      await serviceDataSource.addService(service);
      print('Successfully created service: ${serviceData['name']}');
    } catch (e) {
      print('Error creating service ${serviceData['name']}: $e');
    }
  }

  print('Service seeding completed.');
}
