import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';

part 'program_model.g.dart';

@HiveType(typeId: 24)
class ProgramModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String deletedAt;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final FiscalYear fiscalYear;
  ProgramModel({
    required this.id,
    required this.createdAt,
    required this.deletedAt,
    required this.title,
    required this.fiscalYear,
  });

  ProgramModel copyWith({
    String? id,
    String? createdAt,
  String? deletedAt,
    String? title,
    FiscalYear? fiscalYear,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      fiscalYear: fiscalYear ?? this.fiscalYear,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'title': title,
      'fiscalYear': fiscalYear.toMap(),
    };
  }

  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      deletedAt: map['deletedAt'] ?? "",
      title: map['title'] ?? "",
      fiscalYear: FiscalYear.fromMap(map['fiscalYear'] ?? {}),
    );
  }

  @override
  bool operator ==(covariant ProgramModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.deletedAt == deletedAt &&
        other.title == title &&
        other.fiscalYear == fiscalYear;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        deletedAt.hashCode ^
        title.hashCode ^
        fiscalYear.hashCode;
  }
}
