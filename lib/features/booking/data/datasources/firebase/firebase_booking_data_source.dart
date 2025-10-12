import '../../../../../../../../../core/error/failures.dart';
import '../../../../../../../../../features/booking/data/models/booking_model.dart';
import '../../../../../../../../../features/booking/domain/entities/booking.dart';
import '../../../../data/datasources/booking_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseBookingDataSource implements BookingDataSource {
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');

  final FirebaseAuth firebaseAuth;

  FirebaseBookingDataSource({required this.firebaseAuth});

  @override
  Future<BookingModel> createBookingModel(BookingModel bookingModel) async {
    final String userId = firebaseAuth.currentUser?.uid ?? '';
    if (userId.isEmpty) {
      throw const AuthFailure('User not authenticated');
    }

    // Ensure the booking has an ID or generate one
    final String bookingId = bookingModel.id.isNotEmpty
        ? bookingModel.id
        : bookingsCollection.doc().id;

    // Create the booking document
    final DocumentReference documentReference = bookingsCollection.doc(bookingId);
    
    // Convert the booking model to JSON and add it to Firestore
    final Map<String, dynamic> bookingData = bookingModel.toJson();
    
    // Add audit fields
    bookingData['createdById'] = userId;
    bookingData['createdOn'] = FieldValue.serverTimestamp();
    bookingData['status'] = 'pending';  // Default status
    
    await documentReference.set(bookingData);
    
    // Return the updated model with the generated ID
    return BookingModel.fromJson({
      ...bookingData,
      'id': bookingId
    });
  }

  @override
  Future<List<BookingModel>> getBookingsByProfessionalId(String professionalId) async {
    final String userId = firebaseAuth.currentUser?.uid ?? '';
    if (userId.isEmpty) {
      throw const AuthFailure('User not authenticated');
    }

    final QuerySnapshot querySnapshot = await bookingsCollection
      .where('professionalId', isEqualTo: professionalId)
      .where('status', isNotEqualTo: 'cancelled')
      .orderBy('dateTime')
      .get();
    
    final List<BookingModel> bookings = querySnapshot.docs.map((DocumentSnapshot document) {
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      return BookingModel.fromJson(data);
    }).toList();
    
    return bookings;
  }
}