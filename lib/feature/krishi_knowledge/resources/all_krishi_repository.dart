import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_model.dart';

class AllKrishiRepository {
  final Map<String, AgricultureModel> _krishi = {};
  Map<String, AgricultureModel> get getkrishi => _krishi;

  addAll(Map<String, AgricultureModel> other) {
    _krishi.addAll(other);
  }
}
