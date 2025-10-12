class BookingConfirmationModel {
  final String bookingId;
  final bool isConfirmed;
  final String? confirmationDetails;

  BookingConfirmationModel({
    required this.bookingId,
    required this.isConfirmed,
    this.confirmationDetails,
  });

  factory BookingConfirmationModel.fromJson(Map<String, dynamic> json) {
    return BookingConfirmationModel(
      bookingId: json['bookingId'],
      isConfirmed: json['isConfirmed'] ?? false,
      confirmationDetails: json['confirmationDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'isConfirmed': isConfirmed,
      'confirmationDetails': confirmationDetails,
    };
  }
}