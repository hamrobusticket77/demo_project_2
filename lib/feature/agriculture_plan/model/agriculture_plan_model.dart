import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/common/model/media_model.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';

part 'agriculture_plan_model.g.dart';

@HiveType(typeId: 29)
class AgriculturePlanModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String farmerType;
  @HiveField(3)
  final String contactPersonName;
  @HiveField(4)
  final int benefittedHHS;
  @HiveField(5)
  final int totalCost;
  @HiveField(6)
  final int municipalityExpectedCost;
  @HiveField(7)
  final String landArea;
  @HiveField(8)
  final String activities;
  @HiveField(9)
  final String remarks;
  @HiveField(10)
  final FiscalYear fiscalYear;
  @HiveField(11)
  final ProgramModel program;
  @HiveField(12)
  final ProgramModel project;
  @HiveField(13)
  final PlanningService planningService;
  @HiveField(14)
  final MediaModel? media;

  AgriculturePlanModel({
    required this.id,
    required this.createdAt,
    required this.farmerType,
    required this.contactPersonName,
    required this.benefittedHHS,
    required this.totalCost,
    required this.municipalityExpectedCost,
    required this.landArea,
    required this.activities,
    required this.remarks,
    required this.fiscalYear,
    required this.program,
    required this.project,
    required this.planningService,
    required this.media,
  });

  factory AgriculturePlanModel.fromJson(Map<String, dynamic> json) {
    return AgriculturePlanModel(
        id: json['id'] ?? "",
        createdAt: json['createdAt'] ?? "",
        farmerType: json['farmerType'] ?? "",
        contactPersonName: json['contactPersonName'] ?? "",
        benefittedHHS: json['benefittedHHS'] ?? 0,
        totalCost: json['totalCost'] ?? 0,
        municipalityExpectedCost: json['municipalityExpectedCost'] ?? 0,
        landArea: json['landArea'] ?? "",
        activities: json['activities'] ?? "",
        remarks: json['remarks'] ?? "",
        fiscalYear: FiscalYear.fromMap(json['fiscalYear']),
        program: ProgramModel.fromMap(json['program']),
        project: ProgramModel.fromMap(json['project']),
        planningService: PlanningService.fromJson(json['planningService']),
        media:
            (json['media'] != null) ? MediaModel.fromMap(json['media']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'farmerType': farmerType,
      'contactPersonName': contactPersonName,
      'benefittedHHS': benefittedHHS,
      'totalCost': totalCost,
      'municipalityExpectedCost': municipalityExpectedCost,
      'landArea': landArea,
      'activities': activities,
      'remarks': remarks,
      'fiscalYear': fiscalYear.toMap(),
      'program': program.toMap(),
      'project': project.toMap(),
      'planningService': planningService.toJson(),
      'media': media?.toMap(),
    };
  }
}

@HiveType(typeId: 30)
class PlanningService {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String services;

  PlanningService({
    required this.id,
    required this.services,
  });

  factory PlanningService.fromJson(Map<String, dynamic> json) {
    return PlanningService(
      id: json['id'] ?? "",
      services: json['services'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'services': services,
    };
  }
}
