// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:krishi_hub/common/model/media_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_type.dart';

class AgricultureKnowledgeModel {
  int id;
  Category category;
  Name name;
  AgricultureType agricultureType;
  MediaModel media;
  AgricultureKnowledgeModel({
    required this.id,
    required this.category,
    required this.name,
    required this.agricultureType,
    required this.media,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category.toMap(),
      'name': name.toMap(),
      'agricultureType': agricultureType.toMap(),
      'media': media.toMap(),
    };
  }

  factory AgricultureKnowledgeModel.fromMap(Map<String, dynamic> map) {
    return AgricultureKnowledgeModel(
      id: map['id'] ?? 0 - 1,
      category: Category.fromMap(map['category'] ?? {}),
      name: Name.fromMap(map['name'] ?? {}),
      agricultureType: AgricultureType.fromMap(map['agricultureType'] ?? {}),
      media: MediaModel.fromMap(map['media'] ?? {}),
    );
  }

  AgricultureKnowledgeModel copyWith({
    int? id,
    Category? category,
    Name? name,
    AgricultureType? agricultureType,
    MediaModel? media,
  }) {
    return AgricultureKnowledgeModel(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      agricultureType: agricultureType ?? this.agricultureType,
      media: media ?? this.media,
    );
  }

  @override
  String toString() {
    return 'AgricultureKnowledgeModel(id: $id, category: $category, name: $name, agricultureType: $agricultureType, media: $media)';
  }

  @override
  bool operator ==(covariant AgricultureKnowledgeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.name == name &&
        other.agricultureType == agricultureType &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        name.hashCode ^
        agricultureType.hashCode ^
        media.hashCode;
  }
}

class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? 1 - 1,
      name: map['name'] ?? "",
    );
  }

  Category copyWith({
    int? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'Category(id: $id, name: $name)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Name {
  String name;

  Name({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      name: map['name'] ?? "",
    );
  }

  Name copyWith({
    String? name,
  }) {
    return Name(
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'Name(name: $name)';

  @override
  bool operator ==(covariant Name other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
