import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:krishi_hub/common/model/media_model.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';

part 'product_model.g.dart';

@HiveType(typeId: 34)
class ProductModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String productionDate;
  @HiveField(3)
  final String unit;
  @HiveField(4)
  final int quantity;
  @HiveField(5)
  final int estimatedPriceperunit;
  @HiveField(6)
  final String description;
  @HiveField(7)
  final Crops crops;
  @HiveField(8)
  final List<StatusActivity> statusActivity;
  @HiveField(9)
  final MediaModel? media;
  ProductModel({
    required this.id,
    required this.createdAt,
    required this.productionDate,
    required this.unit,
    required this.quantity,
    required this.estimatedPriceperunit,
    required this.description,
    required this.crops,
    required this.statusActivity,
    this.media,
  });

  ProductModel copyWith({
    String? id,
    String? createdAt,
    String? productionDate,
    String? unit,
    int? quantity,
    int? estimatedPriceperunit,
    String? description,
    Crops? crops,
    List<StatusActivity>? statusActivity,
    MediaModel? media,
  }) {
    return ProductModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      productionDate: productionDate ?? this.productionDate,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      estimatedPriceperunit:
          estimatedPriceperunit ?? this.estimatedPriceperunit,
      description: description ?? this.description,
      crops: crops ?? this.crops,
      statusActivity: statusActivity ?? this.statusActivity,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'productionDate': productionDate,
      'unit': unit,
      'quantity': quantity,
      'estimatedPriceperunit': estimatedPriceperunit,
      'description': description,
      'crops': crops.toMap(),
      'statusActivity': statusActivity.map((x) => x.toMap()).toList(),
      'media': media?.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      productionDate: map['productionDate'] ?? "",
      unit: map['unit'] ?? "",
      quantity: map['quantity'] ?? 0,
      estimatedPriceperunit: map['estimatedPriceperunit'] ?? 0,
      description: map['description'] ?? "",
      crops: Crops.fromMap(map['crops'] ?? {}),
      statusActivity: List.from(map['statusActivity'] ?? [])
          .map((e) => StatusActivity.fromMap(e))
          .toList(),
      media:
          map['media'] != null ? MediaModel.fromMap(map['media'] ?? {}) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, createdAt: $createdAt, productionDate: $productionDate, unit: $unit, quantity: $quantity, estimatedPriceperunit: $estimatedPriceperunit, description: $description, crops: $crops, statusActivity: $statusActivity, media: $media)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.productionDate == productionDate &&
        other.unit == unit &&
        other.quantity == quantity &&
        other.estimatedPriceperunit == estimatedPriceperunit &&
        other.description == description &&
        other.crops == crops &&
        listEquals(other.statusActivity, statusActivity) &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        productionDate.hashCode ^
        unit.hashCode ^
        quantity.hashCode ^
        estimatedPriceperunit.hashCode ^
        description.hashCode ^
        crops.hashCode ^
        statusActivity.hashCode ^
        media.hashCode;
  }
}

@HiveType(typeId: 35)
class StatusActivity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String status;
  @HiveField(3)
  final String remarks;
  StatusActivity({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.remarks,
  });

  StatusActivity copyWith({
    String? id,
    String? createdAt,
    String? status,
    String? remarks,
  }) {
    return StatusActivity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      remarks: remarks ?? this.remarks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'status': status,
      'remarks': remarks,
    };
  }

  factory StatusActivity.fromMap(Map<String, dynamic> map) {
    return StatusActivity(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      status: map['status'] ?? "",
      remarks: map['remarks'] ?? "",
    );
  }

  @override
  bool operator ==(covariant StatusActivity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.status == status &&
        other.remarks == remarks;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        status.hashCode ^
        remarks.hashCode;
  }
}

@HiveType(typeId: 36)
class Crops {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final CropTypeModel type;
  Crops({
    required this.id,
    required this.name,
    required this.type,
  });

  Crops copyWith({
    int? id,
    String? name,
    CropTypeModel? type,
  }) {
    return Crops(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type.toMap(),
    };
  }

  factory Crops.fromMap(Map<String, dynamic> map) {
    return Crops(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      type: CropTypeModel.fromMap(map['type'] ?? {}),
    );
  }

  @override
  bool operator ==(covariant Crops other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode;
}
