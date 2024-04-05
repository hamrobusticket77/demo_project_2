import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';

class AllAgricultureRepository {
  final Map<String, AgriculturePlanModel> _agricultureplanlist = {};
  Map<String, AgriculturePlanModel> get getAgriculturePlan =>
      _agricultureplanlist;

  addAll(Map<String, AgriculturePlanModel> other) {
    _agricultureplanlist.addAll(other);
  }

  removeAll() {
    _agricultureplanlist.clear();
  }
}
