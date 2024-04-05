import 'package:krishi_hub/feature/employee/model/elective_representative_model.dart';

class AllElectiveRepresentiveRepository {
  final Map<String, ElectiveRepresentiveModel> _getlective = {};
  Map<String, ElectiveRepresentiveModel> get getelectiverepresentivelist =>
      _getlective;

  addAll(Map<String, ElectiveRepresentiveModel> other) {
    _getlective.addAll(other);
  }

  removeAll() {
    _getlective.clear();
  }
}
