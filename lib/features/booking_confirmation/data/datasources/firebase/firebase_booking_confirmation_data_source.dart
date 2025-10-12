import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/error/failures.dart';
import '../../models/booking_confirmation_model.dart';
import '../booking_confirmation_data_source.dart';

class FirebaseBookingConfirmationDataSource
    implements BookingConfirmationDataSource {
  final CollectionReference bookingConfirmationsCollection = FirebaseFirestore
      .instance
      .collection('bookingConfirmations');

  @override
  Future<BookingConfirmationModel> getBookingConfirmation(
      String bookingId) async {
    try {
      final DocumentSnapshot snapshot = await bookingConfirmationsCollection
          .doc(bookingId)
          .get();

      if (!snapshot.exists) {
        throw ServerFailure(
            'Booking confirmation not found for booking id: $bookingId');
      }

      return BookingConfirmationModel.fromJson(
          snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<BookingConfirmationModel> setBookingConfirmation(
      BookingConfirmationModel confirmation) async {
    try {
      await bookingConfirmationsCollection
          .doc(confirmation.bookingId)
          .set(confirmation.toJson());
      return confirmation;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}