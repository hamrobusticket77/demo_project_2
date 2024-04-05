import 'package:krishi_hub/feature/krishi_knowledge/models/disease_report_view_model.dart';

class AllDiseaseReportRepository {
  final Map<String, DiseaseReportViewModel> _diseaseReportList = {};
  Map<String, DiseaseReportViewModel> get getDiseaseReportList =>
      _diseaseReportList;

  addAll(Map<String, DiseaseReportViewModel> other) {
    _diseaseReportList.addAll(other);
  }
}
