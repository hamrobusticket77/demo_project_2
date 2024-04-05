// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';

part 'crop_type_model.g.dart';

@HiveType(typeId: 11)
class CropTypeModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final AgricultureName? agricultureName;
  CropTypeModel({required this.id, required this.name, this.agricultureName});

  CropTypeModel copyWith({
    int? id,
    String? name,
    AgricultureName? agricultureName,
  }) {
    return CropTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      agricultureName: agricultureName ?? this.agricultureName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'agricultureName': agricultureName,
    };
  }

  factory CropTypeModel.fromMap(Map<String, dynamic> map) {
    return CropTypeModel(
      id: map['id'] ?? -1,
      name: map['name'] ?? "",
      agricultureName: (map['agricultureName'] != null)
          ? AgricultureName.fromMap(map['agricultureName'])
          : null,
    );
  }

  @override
  bool operator ==(covariant CropTypeModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
