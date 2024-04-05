import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_type/cubit/get_all_crop_categories_cubit.dart';
import 'package:krishi_hub/feature/crop_type/resource/crop_repository.dart';
import 'package:krishi_hub/feature/product/cubit/create_product_cubit.dart';
import 'package:krishi_hub/feature/product/model/product_model.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';
import 'package:krishi_hub/feature/product/ui/widget/product_form_widget.dart';

class ProductFormPage extends StatelessWidget {
  final ProductModel? productModel;
  const ProductFormPage({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetAllCropCategoriesCubit(
                cropRepository: RepositoryProvider.of<CropRepository>(context))
              ..getAllCropCategories(),
          ),
          BlocProvider(
            create: (context) => CreateProductCubit(
                productRepository:
                    RepositoryProvider.of<ProductRepository>(context)),
          ),
        ],
        child: ProductFormWidget(
          productModel: productModel,
        ));
  }
}
