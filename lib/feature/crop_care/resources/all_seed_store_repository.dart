import 'package:krishi_hub/feature/crop_care/model/fertilizer_store_model.dart';

class AllSeedstoreRepository {
  final Map<String, FertilizerStoreModel> _getSeedStore = {};
  Map<String, FertilizerStoreModel> get getSeedStore => _getSeedStore;

  addAll(Map<String, FertilizerStoreModel> other) {
    _getSeedStore.addAll(other);
  }

  removeAll() {
    _getSeedStore.clear();
  }
}
