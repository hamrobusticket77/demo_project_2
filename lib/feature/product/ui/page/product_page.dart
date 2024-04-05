import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/product/cubit/product_cubit.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';
import 'package:krishi_hub/feature/product/ui/widget/product_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
          // createProductCubit:
          //     RepositoryProvider.of<CreateProductCubit>(context),
          productRepository: RepositoryProvider.of<ProductRepository>(context))
        ..getProduct(),
      child: const ProductWidget(),
    );
  }
}
