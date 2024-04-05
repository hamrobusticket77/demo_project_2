import 'package:krishi_hub/feature/traning/model/training_model.dart';

class AllTraningRepositiry {
  final Map<String, TrainingModel> _traninglist = {};
  Map<String, TrainingModel> get getTraningList => _traninglist;

  addAll(Map<String, TrainingModel> other) {
    _traninglist.addAll(other);
  }

  removeAll() {
    _traninglist.clear();
  }
}
