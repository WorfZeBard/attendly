// scripts/seed_notifications.dart
import 'package:attendly/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;
  final notificationsRef = firestore.collection('notifications');

  final notificationData = {
    'id': 'notif_001',
    'userId': 'client_456',
    'message': 'Your booking on Dec 10 has been confirmed!',
    'timestamp': FieldValue.serverTimestamp(),
  };

  await notificationsRef.doc('notif_001').set(notificationData);
  print('✅ Seeded notification: notif_001');
}
