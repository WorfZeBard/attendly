import 'package:equatable/equatable.dart';

class BusinessHours extends Equatable {
  final String professionalId;
  final List<String> workingDays; // e.g. ['Mon', 'Tue', 'Wed']
  final String startTime; // e.g. '09:00'
  final String endTime; // e.g. '18:00'
  final List<Map<String, String>>
      breaks; // e.g. [{'start': '12:00', 'end': '13:00'}]

  const BusinessHours({
    required this.professionalId,
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.breaks,
  });

  @override
  List<Object?> get props => [
        professionalId,
        workingDays,
        startTime,
        endTime,
        breaks,
      ];
}
