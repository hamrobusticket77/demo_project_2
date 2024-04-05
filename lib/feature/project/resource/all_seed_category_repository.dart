import 'package:krishi_hub/feature/project/model/seed_category_model.dart';

class AllSeedCategoryRepository {
  final Map<String, SeedCategoryModel> _items = {};
  Map<String, SeedCategoryModel> get getItems => _items;

  addAll(Map<String, SeedCategoryModel> other) {
    _items.addAll(other);
  }
}
