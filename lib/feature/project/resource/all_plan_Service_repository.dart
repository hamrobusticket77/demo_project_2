import 'package:krishi_hub/feature/project/model/plan_service_model.dart';

class AllPlanServiceRepository {
  final Map<String, PlanServiceModel> _items = {};
  Map<String, PlanServiceModel> get getItems => _items;

  addAll(Map<String, PlanServiceModel> other) {
    _items.addAll(other);
  }
}
