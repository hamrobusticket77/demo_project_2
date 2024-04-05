import 'package:hive_flutter/hive_flutter.dart';

part 'fiscal_year.g.dart';

@HiveType(typeId: 19)
class FiscalYear {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String startDate;
  @HiveField(2)
  final String endDate;
  @HiveField(3)
  final String fiscalYear;
  @HiveField(4)
  final bool isActive;

  FiscalYear({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.fiscalYear,
    required this.isActive,
  });

  factory FiscalYear.fromMap(Map<String, dynamic> json) {
    return FiscalYear(
      id: json['id'] ?? "",
      startDate: json['startDate'] ?? "",
      endDate: json['endDate'] ?? "",
      fiscalYear: json['fiscalYear'] ?? "",
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate,
      'endDate': endDate,
      'fiscalyYear': fiscalYear,
      'isActive': isActive,
    };
  }
}
