import 'dart:convert';

import 'package:krishi_hub/feature/market_price/model/category_model.dart';

class ProductModel {
  final String id;
  final String createdAt;
  final String title;
  final CategoryModel category;
  ProductModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.category,
  });

  ProductModel copyWith({
    String? id,
    String? createdAt,
    String? title,
    CategoryModel? category,
  }) {
    return ProductModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'category': category.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      title: map['title'] ?? "",
      category: CategoryModel.fromMap(map['category'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, createdAt: $createdAt, title: $title, category: $category)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.title == title &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        title.hashCode ^
        category.hashCode;
  }
}
