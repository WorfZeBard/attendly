import '../../../../../../../../../core/error/failures.dart';
import '../../../../../../../../../features/business_hours/data/models/business_hours_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BusinessHoursFirestoreDataSource {
  final CollectionReference businessHoursCollection =
  FirebaseFirestore.instance.collection('business_hours');

  final FirebaseAuth firebaseAuth;

  BusinessHoursFirestoreDataSource(
      {required this.firebaseAuth});

  // No Either<Failure, T> here (contrasts with repository)
  Future<BusinessHoursModel> setBusinessHours(BusinessHoursModel businessHours) async {
    final String professionalId = businessHours.professionalId;
    final DocumentReference docRef = businessHoursCollection.doc(professionalId);
    final DocumentSnapshot docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      // Update existing business hours
      await docRef.update(businessHours.toJson());
    } else {
      // Create new business hours
      await docRef.set(businessHours.toJson());
    }

    return businessHours;
  }

  Future<BusinessHoursModel> getBusinessHours(String professionalId) async {
    final DocumentSnapshot snapshot =
    await businessHoursCollection.doc(professionalId).get();

    if (!snapshot.exists) {
      throw Exception('Business hours not found for professional id: $professionalId');
    }

    return BusinessHoursModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}