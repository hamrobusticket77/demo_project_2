import 'package:hive_flutter/hive_flutter.dart';

part 'sub_category_model.g.dart';

@HiveType(typeId: 22)
class SubCategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  SubCategoryModel({
    required this.id,
    required this.name,
  });

  SubCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
    );
  }

  @override
  bool operator ==(covariant SubCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
