import '../models/service_model.dart';

abstract class ServiceDataSource {
  Future<ServiceModel> addService(ServiceModel service);
  Future<List<ServiceModel>> getServices(String professionalId);
  Future<void> removeService(String serviceId);
}