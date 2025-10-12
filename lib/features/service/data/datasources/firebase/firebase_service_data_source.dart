import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/failures.dart';
import '../../../domain/entities/service.dart';
import '../../models/service_model.dart';
import '../service_data_source.dart';

class FirebaseServiceDataSource implements ServiceDataSource {
  final CollectionReference servicesCollection = FirebaseFirestore.instance.collection('services');

  @override
  Future<ServiceModel> addService(ServiceModel service) async {
    try {
      final documentReference = await servicesCollection.add(service.toJson());
      final snapshot = await documentReference.get();
      return ServiceModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<ServiceModel>> getServices(String professionalId) async {
    try {
      final querySnapshot = await servicesCollection.where('professionalId', isEqualTo: professionalId).get();
      return querySnapshot.docs
          .map((doc) => ServiceModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> removeService(String serviceId) async {
    try {
      await servicesCollection.doc(serviceId).delete();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}