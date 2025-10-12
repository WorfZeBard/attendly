import '../models/booking_confirmation_model.dart';

abstract class BookingConfirmationDataSource {
  Future<BookingConfirmationModel> getBookingConfirmation(String bookingId);
  Future<BookingConfirmationModel> setBookingConfirmation(
      BookingConfirmationModel confirmation);
}