import '../../../../domain/entities/booking.dart';

class BookingModel extends Booking {
  BookingModel({
    required super.id,
    required super.clientId,
    required super.professionalId,
    required super.dateTime,
  });

  factory BookingModel.fromEntity(Booking entity) {
    return BookingModel(
      id: entity.id,
      clientId: entity.clientId,
      professionalId: entity.professionalId,
      dateTime: entity.dateTime,
    );
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      clientId: json['clientId'],
      professionalId: json['professionalId'],
      dateTime: (json['dateTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'professionalId': professionalId,
      'dateTime': dateTime,
    };
  }
}