import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/feature/demand/model/farmer_model.dart';
import 'package:krishi_hub/feature/demand/model/quantity_details_model.dart';
part 'applied_demand_model.g.dart';

@HiveType(typeId: 23)
class AppliedDemandModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final FarmerModel farmer;
  @HiveField(2)
  final int? appliedQuantity;
  @HiveField(3)
  final int? grantedQuantity;
  @HiveField(4)
  final String? grantDate;
  @HiveField(5)
  final QuantityDetails? demandQuantity;
  AppliedDemandModel({
    required this.id,
    required this.farmer,
    this.appliedQuantity,
    this.grantedQuantity,
    this.grantDate,
    this.demandQuantity,
  });

  AppliedDemandModel copyWith({
    String? id,
    FarmerModel? farmer,
    int? appliedQuantity,
    int? grantedQuantity,
    String? grantDate,
    QuantityDetails? demandQuantity,
  }) {
    return AppliedDemandModel(
      id: id ?? this.id,
      farmer: farmer ?? this.farmer,
      appliedQuantity: appliedQuantity ?? this.appliedQuantity,
      grantedQuantity: grantedQuantity ?? this.grantedQuantity,
      grantDate: grantDate ?? this.grantDate,
      demandQuantity: demandQuantity ?? this.demandQuantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'farmer': farmer.toMap(),
      'appliedQuantity': appliedQuantity,
      'grantedQuantity': grantedQuantity,
      'grantDate': grantDate,
      "demandQuantity": demandQuantity?.toMap()
    };
  }

  factory AppliedDemandModel.fromMap(Map<String, dynamic> map) {
    return AppliedDemandModel(
      id: map['id'] ?? "",
      farmer: FarmerModel.fromMap(map['farmer'] ?? {}),
      appliedQuantity:
          map['appliedQuantity'] != null ? map['appliedQuantity'] as int : null,
      grantedQuantity:
          map['grantedQuantity'] != null ? map['grantedQuantity'] as int : null,
      grantDate: map['grantDate'] != null ? map['grantDate'] ?? "" : null,
      demandQuantity: map['demandQuantity'] != null
          ? QuantityDetails.fromMap(map['demandQuantity'] ?? {})
          : null,
    );
  }

  @override
  bool operator ==(covariant AppliedDemandModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.farmer == farmer &&
        other.appliedQuantity == appliedQuantity &&
        other.grantedQuantity == grantedQuantity &&
        other.grantDate == grantDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        farmer.hashCode ^
        appliedQuantity.hashCode ^
        grantedQuantity.hashCode ^
        grantDate.hashCode;
  }
}
