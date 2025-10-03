// entities/professional.dart
import 'package:equatable/equatable.dart';

class Professional extends Equatable {
  final String id;
  final String businessName;
  final String? logoUrl;

  const Professional({
    required this.id,
    required this.businessName,
    this.logoUrl,
  });

  @override
  List<Object?> get props => [id, businessName, logoUrl];
}


