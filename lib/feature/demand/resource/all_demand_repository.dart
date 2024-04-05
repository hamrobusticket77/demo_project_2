import 'package:krishi_hub/feature/demand/model/demand_model.dart';

class AllDemandListRepository {
  final Map<String, DemandModel> _alldemandlist = {};
  Map<String, DemandModel> get getdemandlist => _alldemandlist;

  addAll(Map<String, DemandModel> other) {
    _alldemandlist.addAll(other);
  }

  removeAll() {
    _alldemandlist.clear();
  }
}
