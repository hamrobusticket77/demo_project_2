import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';

part 'agriculture_type.g.dart';

@HiveType(typeId: 13)
class AgricultureType {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final MultiLanguage title;
  @HiveField(2)
  final List<AgricultureName> agricultureName;

  AgricultureType({
    required this.id,
    required this.title,
    required this.agricultureName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title.toJson(),
      'agricultureName': agricultureName.map((x) => x.toMap()).toList(),
    };
  }

  factory AgricultureType.fromMap(Map<String, dynamic> map) {
    return AgricultureType(
        id: map['id'] ?? 0 - 1,
        title: MultiLanguage.fromJson(map['title'] ?? {}),
        agricultureName: List.from(map['agricultureName'] ?? [])
            .map((e) => AgricultureName.fromMap(e))
            .toList());
  }

  String toJson() => json.encode(toMap());

  factory AgricultureType.fromJson(String source) =>
      AgricultureType.fromMap(json.decode(source) as Map<String, dynamic>);

  AgricultureType copyWith({
    int? id,
    MultiLanguage? title,
    List<AgricultureName>? agricultureName,
  }) {
    return AgricultureType(
      id: id ?? this.id,
      title: title ?? this.title,
      agricultureName: agricultureName ?? this.agricultureName,
    );
  }

  @override
  String toString() =>
      'AgricultureType(id: $id, title: $title, agricultureName: $agricultureName)';

  @override
  bool operator ==(covariant AgricultureType other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.agricultureName, agricultureName);
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ agricultureName.hashCode;
}
