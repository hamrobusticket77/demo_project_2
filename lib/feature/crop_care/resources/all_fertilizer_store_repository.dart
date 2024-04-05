import 'package:krishi_hub/feature/crop_care/model/fertilizer_store_model.dart';

class AllFertilizerStoreRepository {
  final Map<String, FertilizerStoreModel> _getFertilizerStore = {};
  Map<String, FertilizerStoreModel> get getFertilizerStore =>
      _getFertilizerStore;

  addAll(Map<String, FertilizerStoreModel> other) {
    _getFertilizerStore.addAll(other);
  }

  removeAll() {
    _getFertilizerStore.clear();
  }
}
