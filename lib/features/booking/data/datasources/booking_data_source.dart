import '../../../booking/data/models/booking_model.dart';

abstract class BookingDataSource {
  Future<BookingModel> createBookingModel(BookingModel bookingModel);
  Future<List<BookingModel>> getBookingsByProfessionalId(String professionalId);
}