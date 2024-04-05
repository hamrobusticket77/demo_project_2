import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/feature/project/model/plan_service_model.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';

part 'project_model.g.dart';

@HiveType(typeId: 18)
class ProjectModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final ProgramModel program;
  @HiveField(3)
  final FiscalYear fiscalYear;
  @HiveField(4)
  final PlanServiceModel? planningService;
  ProjectModel({
    required this.id,
    required this.title,
    required this.program,
    required this.fiscalYear,
    required this.planningService,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'program': program.toMap(),
      'fiscalYear': fiscalYear.toMap(),
      'planningService': planningService?.toMap(),
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
        id: map['id'] ?? "",
        title: map['title'] ?? "",
        program: ProgramModel.fromMap(map['program'] ?? {}),
        fiscalYear: FiscalYear.fromMap(map['fiscalYear'] ?? {}),
        planningService: (map['planningService'] != null)
            ? PlanServiceModel.fromMap(map['planningService'] ?? {})
            : null);
  }

  ProjectModel copyWith({
    String? id,
    String? title,
    ProgramModel? program,
    FiscalYear? fiscalYear,
    PlanServiceModel? planningService,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      program: program ?? this.program,
      fiscalYear: fiscalYear ?? this.fiscalYear,
      planningService: planningService ?? this.planningService,
    );
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, title: $title, program: $program, fiscalYear: $fiscalYear, planningService: $planningService)';
  }

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.program == program &&
        other.fiscalYear == fiscalYear &&
        other.planningService == planningService;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        program.hashCode ^
        fiscalYear.hashCode ^
        planningService.hashCode;
  }
}
