// entities/business_hours.dart
import 'package:equatable/equatable.dart';

class BusinessHours extends Equatable {
  final String professionalId;
  final List<String> workingDays;
  final Map<String, List<String>> timeSlots;

  const BusinessHours({
    required this.professionalId,
    required this.workingDays,
    required this.timeSlots,
  });

  @override
  List<Object?> get props => [professionalId, workingDays, timeSlots];
}
