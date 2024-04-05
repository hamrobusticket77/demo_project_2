import 'package:flutter/foundation.dart';
import 'package:krishi_hub/feature/project/model/sub_category_model.dart';

class SeedCategoryModel {
  final String id;
  final String name;
  final List<SubCategoryModel> seed;
  SeedCategoryModel({
    required this.id,
    required this.name,
    required this.seed,
  });

  SeedCategoryModel copyWith({
    String? id,
    String? name,
    List<SubCategoryModel>? seed,
  }) {
    return SeedCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      seed: seed ?? this.seed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'seed': seed.map((x) => x.toMap()).toList(),
    };
  }

  factory SeedCategoryModel.fromMap(Map<String, dynamic> map) {
    return SeedCategoryModel(
        id: map['id'] ?? "",
        name: map['name'] ?? "",
        seed: List.from(map['seed'] ?? [])
            .map((e) => SubCategoryModel.fromMap(e ?? {}))
            .toList());
  }

  @override
  bool operator ==(covariant SeedCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && listEquals(other.seed, seed);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ seed.hashCode;
}

// class Seed {
//   final String id;
//   final String name;
//   Seed({
//     required this.id,
//     required this.name,
//   });

//   Seed copyWith({
//     String? id,
//     String? name,
//   }) {
//     return Seed(
//       id: id ?? this.id,
//       name: name ?? this.name,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//     };
//   }

//   factory Seed.fromMap(Map<String, dynamic> map) {
//     return Seed(
//       id: map['id'] ?? "",
//       name: map['name'] ?? "",
//     );
//   }

//   @override
//   bool operator ==(covariant Seed other) {
//     if (identical(this, other)) return true;

//     return other.id == id && other.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }
