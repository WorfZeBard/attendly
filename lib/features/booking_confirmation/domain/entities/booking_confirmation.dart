import 'package:equatable/equatable.dart';

class BookingConfirmation extends Equatable {
  final String bookingId;
  final String clientId;
  final String professionalId;
  final DateTime confirmedAt;
  final bool isConfirmed;

  const BookingConfirmation({
    required this.bookingId,
    required this.clientId,
    required this.professionalId,
    required this.confirmedAt,
    required this.isConfirmed,
  });

  @override
  List<Object?> get props => [
        bookingId,
        clientId,
        professionalId,
        confirmedAt,
        isConfirmed,
      ];
}
