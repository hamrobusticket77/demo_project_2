import 'package:flutter/material.dart';
import 'package:krishi_hub/common/model/photo.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';

class DiseaseReportViewModel {
  final String id;
  final String title;
  final String description;
  final CropTypeModel category;
  final CropTypeModel name;
  List<Photos> media;
  DiseaseReportViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.name,
    required this.media,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category.toMap(),
      'crops': name.toMap(),
      'media': media.map((x) => x.toMap()).toList(),
    };
  }

  factory DiseaseReportViewModel.fromMap(Map<String, dynamic> map) {
    return DiseaseReportViewModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: CropTypeModel.fromMap(map['category'] ?? {}),
      name: CropTypeModel.fromMap(map['crops'] ?? {}),
      media: (map['media'] as List<dynamic>)
          .map<Photos>((x) => Photos.fromMap(x ?? {}))
          .toList(),
    );
  }

  DiseaseReportViewModel copyWith({
    String? id,
    String? title,
    String? description,
    CropTypeModel? category,
    CropTypeModel? name,
    List<Photos>? media,
  }) {
    return DiseaseReportViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      name: name ?? this.name,
      media: media ?? this.media,
    );
  }

  @override
  String toString() {
    return 'DiseaseReportViewModel(id: $id, title: $title, description: $description, category: $category, name: $name)';
  }

  @override
  bool operator ==(covariant DiseaseReportViewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        name.hashCode;
  }
}
