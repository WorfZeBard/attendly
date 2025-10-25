import '../../domain/entities/business_hours.dart';

class BusinessHoursModel extends BusinessHours {
  const BusinessHoursModel({
    required super.professionalId,
    required super.workingDays,
    required super.startTime,
    required super.endTime,
    required super.breaks,
  });

  /// ✅ Converts a domain entity into a data model
  factory BusinessHoursModel.fromEntity(BusinessHours entity) {
    return BusinessHoursModel(
      professionalId: entity.professionalId,
      workingDays: entity.workingDays,
      startTime: entity.startTime,
      endTime: entity.endTime,
      breaks: entity.breaks,
    );
  }

  /// ✅ Converts Firestore JSON into a model
  factory BusinessHoursModel.fromJson(Map<String, dynamic> json) {
    return BusinessHoursModel(
      professionalId: json['professionalId'] ?? '',
      workingDays: List<String>.from(json['workingDays'] ?? []),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      breaks: (json['breaks'] as List?)
              ?.map((b) => Map<String, String>.from(b))
              .toList() ??
          [],
    );
  }

  /// ✅ Converts model into JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'professionalId': professionalId,
      'workingDays': workingDays,
      'startTime': startTime,
      'endTime': endTime,
      'breaks': breaks,
    };
  }
}
