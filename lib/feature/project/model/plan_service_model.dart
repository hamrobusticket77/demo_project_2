import 'package:hive_flutter/hive_flutter.dart';

part 'plan_service_model.g.dart';

@HiveType(typeId: 20)
class PlanServiceModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String services;
  PlanServiceModel({
    required this.id,
    required this.services,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'services': services,
    };
  }

  factory PlanServiceModel.fromMap(Map<String, dynamic> map) {
    return PlanServiceModel(
      id: map['id'] ?? "",
      services: map['services'] ?? "",
    );
  }

  PlanServiceModel copyWith({
    String? id,
    String? createdAt,
    String? services,
  }) {
    return PlanServiceModel(
      id: id ?? this.id,
      services: services ?? this.services,
    );
  }

  @override
  String toString() => 'PlanserviceModel(id: $id,  services: $services)';

  @override
  bool operator ==(covariant PlanServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.services == services;
  }

  @override
  int get hashCode => id.hashCode ^ services.hashCode;
}
