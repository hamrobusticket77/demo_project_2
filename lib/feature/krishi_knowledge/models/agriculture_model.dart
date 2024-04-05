import 'package:hive_flutter/hive_flutter.dart';

import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_type.dart';

part 'agriculture_model.g.dart';

@HiveType(typeId: 12)
class AgricultureModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  MultiLanguage title;
  @HiveField(2)
  List<AgricultureType> agricultureType;

  AgricultureModel({
    required this.id,
    required this.title,
    required this.agricultureType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title.toJson(),
      'agricultureType': agricultureType.map((e) => e.toMap()),
    };
  }

  factory AgricultureModel.fromMap(Map<String, dynamic> map) {
    return AgricultureModel(
      id: map['id'] ?? 1 - 0,
      title: MultiLanguage.fromJson(map['title'] ?? {}),
      agricultureType: List.from(map['agricultureType'] ?? [])
          .map((e) => AgricultureType.fromMap(e))
          .toList(),
    );
  }

  AgricultureModel copyWith({
    int? id,
    MultiLanguage? title,
    List<AgricultureType>? agricultureType,
  }) {
    return AgricultureModel(
      id: id ?? this.id,
      title: title ?? this.title,
      agricultureType: agricultureType ?? this.agricultureType,
    );
  }

  @override
  String toString() =>
      'AgricultureModel(id: $id, title: $title, agricultureType: $agricultureType)';

  @override
  bool operator ==(covariant AgricultureModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.agricultureType == agricultureType;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ agricultureType.hashCode;
}
