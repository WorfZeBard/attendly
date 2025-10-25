import '../../domain/entities/booking_confirmation.dart';

class BookingConfirmationModel extends BookingConfirmation {
  const BookingConfirmationModel({
    required super.bookingId,
    required super.clientId,
    required super.professionalId,
    required super.confirmedAt,
    required super.isConfirmed,
  });

  factory BookingConfirmationModel.fromJson(Map<String, dynamic> json) {
    return BookingConfirmationModel(
      bookingId: json['bookingId'],
      clientId: json['clientId'],
      professionalId: json['professionalId'],
      confirmedAt: DateTime.parse(json['confirmedAt']),
      isConfirmed: json['isConfirmed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'bookingId': bookingId,
        'clientId': clientId,
        'professionalId': professionalId,
        'confirmedAt': confirmedAt.toIso8601String(),
        'isConfirmed': isConfirmed,
      };
}
