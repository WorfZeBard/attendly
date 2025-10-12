import '../../../../domain/entities/service.dart';

class ServiceModel extends Service {
  ServiceModel({
    required super.id,
    required super.professionalId,
    required super.name,
    required super.durationMinutes,
    required super.price,
  });

  factory ServiceModel.fromEntity(Service service) {
    return ServiceModel(
      id: service.id,
      professionalId: service.professionalId,
      name: service.name,
      durationMinutes: service.durationMinutes,
      price: service.price,
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      professionalId: json['professionalId'],
      name: json['name'],
      durationMinutes: json['durationMinutes'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'professionalId': professionalId,
      'name': name,
      'durationMinutes': durationMinutes,
      'price': price,
    };
  }
}