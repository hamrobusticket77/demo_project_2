import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/feature/demand/model/applied_demand_model.dart';
import 'package:krishi_hub/feature/project/model/sub_category_model.dart';

part 'quantity_details_model.g.dart';

@HiveType(typeId: 21)
class QuantityDetails {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final SubCategoryModel subCategory;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final List<AppliedDemandModel> appliedDemand;
  QuantityDetails({
    required this.id,
    required this.createdAt,
    required this.subCategory,
    required this.quantity,
    required this.appliedDemand,
  });

  QuantityDetails copyWith({
    String? id,
    String? createdAt,
    SubCategoryModel? subCategory,
    List<AppliedDemandModel>? appliedDemand,
    int? quantity,
  }) {
    return QuantityDetails(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      subCategory: subCategory ?? this.subCategory,
      appliedDemand: appliedDemand ?? this.appliedDemand,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'subCategory': subCategory.toMap(),
      'quantity': quantity,
      "appliedDemand": appliedDemand.map((e) => e.toMap()).toList(),
    };
  }

  factory QuantityDetails.fromMap(Map<String, dynamic> map) {
    return QuantityDetails(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      subCategory: SubCategoryModel.fromMap(map['subCategory'] ?? {}),
      quantity: map['quantity'] ?? 0,
      appliedDemand: List.from(map['appliedDemand'] ?? [])
          .map((e) => AppliedDemandModel.fromMap(e))
          .toList(),
    );
  }

  @override
  bool operator ==(covariant QuantityDetails other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.subCategory == subCategory &&
        listEquals(other.appliedDemand, appliedDemand) &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        subCategory.hashCode ^
        appliedDemand.hashCode ^
        quantity.hashCode;
  }
}
