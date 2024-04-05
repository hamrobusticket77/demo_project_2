import 'package:krishi_hub/feature/vission/model/vission_model.dart';

class AllMissionRepository {
  final Map<String, MissionModel> _news = {};
  Map<String, MissionModel> get getmission => _news;

  addAll(Map<String, MissionModel> other) {
    _news.addAll(other);
  }
}
