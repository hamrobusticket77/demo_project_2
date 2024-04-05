import 'package:krishi_hub/feature/demand/model/applied_demand_model.dart';

class AllAppliedDemendRepository {
  final Map<String, AppliedDemandModel> _allAppliedDemand = {};
  Map<String, AppliedDemandModel> get getAppliedDemand => _allAppliedDemand;

  addAll(Map<String, AppliedDemandModel> other) {
    getAppliedDemand.addAll(other);
  }
}
