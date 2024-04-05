import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/feature/demand/model/quantity_details_model.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';
import 'package:krishi_hub/feature/project/model/project_model.dart';

part 'demand_model.g.dart';

@HiveType(typeId: 17)
class DemandModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String createdAt;

  @HiveField(2)
  final dynamic deletedAt;

  @HiveField(3)
  final ProjectModel project;

  @HiveField(4)
  final ProgramModel program;

  @HiveField(5)
  final FiscalYear fiscalYear;

  @HiveField(6)
  final List<QuantityDetails> quantityDetails;

  @HiveField(7)
  final String startDate;

  @HiveField(8)
  final String endDate;

  DemandModel({
    required this.id,
    required this.createdAt,
    required this.deletedAt,
    required this.project,
    required this.program,
    required this.fiscalYear,
    required this.quantityDetails,
    required this.startDate,
    required this.endDate,
  });

  DemandModel copyWith({
    String? id,
    String? createdAt,
    dynamic deletedAt,
    ProjectModel? project,
    ProgramModel? program,
    FiscalYear? fiscalYear,
    List<QuantityDetails>? quantityDetails,
    String? startDate,
    String? endDate,
  }) {
    return DemandModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      project: project ?? this.project,
      program: program ?? this.program,
      fiscalYear: fiscalYear ?? this.fiscalYear,
      quantityDetails: quantityDetails ?? this.quantityDetails,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'project': project.toMap(),
      'program': program.toMap(),
      'fiscalYear': fiscalYear.toMap(),
      'quantityDetails': quantityDetails.map((x) => x.toMap()).toList(),
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory DemandModel.fromMap(Map<String, dynamic> map) {
    return DemandModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      deletedAt: map['deletedAt'] as dynamic,
      project: ProjectModel.fromMap(map['project'] ?? {}),
      program: ProgramModel.fromMap(map['program'] ?? {}),
      fiscalYear: FiscalYear.fromMap(map['fiscalYear'] ?? {}),
      quantityDetails: List.from(map['quantityDetails'] ?? [])
          .map((e) => QuantityDetails.fromMap(e))
          .toList(),
      startDate: map['startDate'] ?? "",
      endDate: map['endDate'] ?? "",
    );
  }

  @override
  bool operator ==(covariant DemandModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.deletedAt == deletedAt &&
        other.project == project &&
        other.program == program &&
        other.fiscalYear == fiscalYear &&
        listEquals(other.quantityDetails, quantityDetails) &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        deletedAt.hashCode ^
        project.hashCode ^
        program.hashCode ^
        fiscalYear.hashCode ^
        quantityDetails.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
