import 'package:krishi_hub/feature/project/model/program_model.dart';

class AllProgramRepository {
  final Map<String, ProgramModel> _items = {};
  Map<String, ProgramModel> get getItems => _items;

  addAll(Map<String, ProgramModel> other) {
    _items.addAll(other);
  }
}
