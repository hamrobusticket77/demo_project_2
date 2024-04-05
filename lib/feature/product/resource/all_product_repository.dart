import 'package:krishi_hub/feature/product/model/product_model.dart';

class AllProductRepository {
  final Map<String, ProductModel> _products = {};
  Map<String, ProductModel> get getProducts => _products;

  addAll(Map<String, ProductModel> other) {
    _products.addAll(other);
  }

  updated(ProductModel other) {
    _products[other.id] = other;
  }

  remove(String place) {
    _products.remove(place);
  }

  removeAll() {
    _products.clear();
  }
}
