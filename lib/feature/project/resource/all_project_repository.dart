import 'package:krishi_hub/feature/project/model/project_model.dart';

class AllProjectRepository {
  final Map<String, ProjectModel> _items = {};
  Map<String, ProjectModel> get getItems => _items;

  addAll(Map<String, ProjectModel> other) {
    _items.addAll(other);
  }
}
