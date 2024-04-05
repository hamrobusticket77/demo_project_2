import 'package:flutter/foundation.dart';

import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_knowledge_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';

class CommonAgricultureKnowledgeModel {
  final int id;
  final AgricultureKnowledgeModel agricultureKnowledgeModel;

  final Details? details;
  List<Disease> disease;
  CommonAgricultureKnowledgeModel({
    required this.id,
    required this.agricultureKnowledgeModel,
    this.details,
    required this.disease,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'agricultureKnowledgeModel': agricultureKnowledgeModel.toMap(),
      'details': details?.toMap(),
      'disease': disease.map((x) => x.toMap()).toList(),
    };
  }

  factory CommonAgricultureKnowledgeModel.fromMap(Map<String, dynamic> map) {
    return CommonAgricultureKnowledgeModel(
      id: map['id'] ?? 1 - 0,
      agricultureKnowledgeModel: AgricultureKnowledgeModel.fromMap(
          map['agricultureKnowledgeModel'] ?? {}),
      details:
          map['details'] != null ? Details.fromMap(map['details'] ?? {}) : null,
      disease: List.from(map['disease'] ?? [])
          .map((e) => Disease.fromMap(e))
          .toList(),
    );
  }

  CommonAgricultureKnowledgeModel copyWith({
    int? id,
    AgricultureKnowledgeModel? agricultureKnowledgeModel,
    Details? details,
    List<Disease>? disease,
  }) {
    return CommonAgricultureKnowledgeModel(
      id: id ?? this.id,
      agricultureKnowledgeModel:
          agricultureKnowledgeModel ?? this.agricultureKnowledgeModel,
      details: details ?? this.details,
      disease: disease ?? this.disease,
    );
  }

  @override
  String toString() {
    return 'CommonAgricultureKnowledgeModel(id: $id, agricultureKnowledgeModel: $agricultureKnowledgeModel, details: $details, disease: $disease)';
  }

  @override
  bool operator ==(covariant CommonAgricultureKnowledgeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.agricultureKnowledgeModel == agricultureKnowledgeModel &&
        other.details == details &&
        listEquals(other.disease, disease);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        agricultureKnowledgeModel.hashCode ^
        details.hashCode ^
        disease.hashCode;
  }
}
