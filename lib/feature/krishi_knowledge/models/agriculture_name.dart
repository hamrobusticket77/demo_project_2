import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/media_model.dart';

import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';

part 'agriculture_name.g.dart';

@HiveType(typeId: 6)
class AgricultureName {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final MultiLanguage title;
  @HiveField(2)
  final CropTypeModel category;
  @HiveField(3)
  final CropTypeModel name;
  @HiveField(4)
  final MediaModel media;
  @HiveField(5)
  final Details? details;
  @HiveField(6)
  List<Disease> disease;
  @HiveField(7)
  AgricultureName({
    required this.id,
    required this.title,
    required this.category,
    required this.name,
    required this.media,
    this.details,
    required this.disease,
  });

  AgricultureName copyWith({
    int? id,
    MultiLanguage? title,
    CropTypeModel? category,
    CropTypeModel? name,
    MediaModel? media,
    Details? details,
    List<Disease>? disease,
  }) {
    return AgricultureName(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      name: name ?? this.name,
      media: media ?? this.media,
      details: details ?? this.details,
      disease: disease ?? this.disease,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title.toJson(),
      'category': category.toMap(),
      'name': name.toMap(),
      'media': media.toMap(),
      'details': details?.toMap(),
      'disease': disease.toList(),
    };
  }

  factory AgricultureName.fromMap(Map<String, dynamic> map) {
    return AgricultureName(
      id: map['id'] ?? -1,
      title: MultiLanguage.fromJson(map['title'] ?? {}),
      category: CropTypeModel.fromMap(map['category'] ?? {}),
      name: CropTypeModel.fromMap(map['name'] ?? {}),
      media: MediaModel.fromMap(map['media'] ?? {}),
      details:
          map['details'] != null ? Details.fromMap(map['details'] ?? {}) : null,
      disease: List.from(map['disease'] ?? [])
          .map((e) => Disease.fromMap(e))
          .toList(),
    );
  }

  @override
  bool operator ==(covariant AgricultureName other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.category == category &&
        other.name == name &&
        other.media == media &&
        other.details == details;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        category.hashCode ^
        name.hashCode ^
        media.hashCode ^
        details.hashCode;
  }
}

@HiveType(typeId: 7)
class Details {
  @HiveField(0)
  int id;
  @HiveField(1)
  List<Value> values;

  Details({
    required this.id,
    required this.values,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'values': values.map((x) => x.toMap()).toList(),
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
        id: map['id'] ?? 0 - 1,
        values: List.from(map['values'] ?? [])
            .map((e) => Value.fromMap(e))
            .toList());
  }

  String toJson() => json.encode(toMap());

  Details copyWith({
    int? id,
    List<Value>? values,
  }) {
    return Details(
      id: id ?? this.id,
      values: values ?? this.values,
    );
  }

  @override
  String toString() => 'Details(id: $id, values: $values)';

  @override
  bool operator ==(covariant Details other) {
    if (identical(this, other)) return true;

    return other.id == id && listEquals(other.values, values);
  }

  @override
  int get hashCode => id.hashCode ^ values.hashCode;
}

@HiveType(typeId: 8)
class Value {
  @HiveField(0)
  String columnName;
  @HiveField(1)
  String values;

  Value({
    required this.columnName,
    required this.values,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'columnName': columnName,
      'values': values,
    };
  }

  factory Value.fromMap(Map<String, dynamic> map) {
    return Value(
        columnName: map['columnName'] ?? '', values: map['values'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Value.fromJson(String source) =>
      Value.fromMap(json.decode(source) as Map<String, dynamic>);

  Value copyWith({
    String? columnName,
    String? values,
  }) {
    return Value(
      columnName: columnName ?? this.columnName,
      values: values ?? this.values,
    );
  }

  @override
  String toString() => 'Value(columnName: $columnName, values: $values)';

  @override
  bool operator ==(covariant Value other) {
    if (identical(this, other)) return true;

    return other.columnName == columnName && other.values == values;
  }

  @override
  int get hashCode => columnName.hashCode ^ values.hashCode;
}

@HiveType(typeId: 9)
class Disease {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  MediaModel? media;

  Disease({
    required this.id,
    required this.title,
    required this.description,
    this.media,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'medias': media?.toMap(),
    };
  }

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      media: map['media'] != null
          ? MediaModel.fromMap(map['media'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Disease.fromJson(String source) =>
      Disease.fromMap(json.decode(source) as Map<String, dynamic>);

  Disease copyWith({
    String? id,
    String? title,
    String? description,
    MediaModel? media,
  }) {
    return Disease(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      media: media ?? this.media,
    );
  }

  @override
  String toString() {
    return 'Disease(id: $id, title: $title, description: $description, medias: $media)';
  }

  @override
  bool operator ==(covariant Disease other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ media.hashCode;
  }
}
