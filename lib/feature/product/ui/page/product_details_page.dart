import 'package:flutter/material.dart';
import 'package:krishi_hub/feature/product/model/product_model.dart';
import 'package:krishi_hub/feature/product/ui/widget/product_details_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel model;
  const ProductDetailsPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return ProductDetailsWidget(
      model: model,
    );
  }
}
