import '../../../../domain/entities/business_hours.dart';

class BusinessHoursModel extends BusinessHours {
  BusinessHoursModel({
    required super.professionalId,
    required super.workingDays,
    required super.timeSlots,
  });

  factory BusinessHoursModel.fromEntity(BusinessHours entity) {
    return BusinessHoursModel(
      professionalId: entity.professionalId,
      workingDays: entity.workingDays,
      timeSlots: entity.timeSlots,
    );
  }

  factory BusinessHoursModel.fromJson(Map<String, dynamic> json) {
    return BusinessHoursModel(
      professionalId: json['professionalId'],
      workingDays: List<String>.from(json['workingDays']),
      timeSlots: Map<String, List<String>>.from(
        (json['timeSlots'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, List<String>.from(value))),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'professionalId': professionalId,
      'workingDays': workingDays,
      'timeSlots': timeSlots.map((key, value) => MapEntry(key, value)),
    };
  }
}