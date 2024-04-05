import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';

class CreateProductCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  CreateProductCubit({required this.productRepository})
      : super(CommonInitial());

  createProduct({
    required String productionDate,
    required int estimatedPricePerUnit,
    required int quantity,
    required String unit,
    required String description,
    required int category,
    required int title,
    required List<File> media,
  }) async {
    emit(CommonLoading());

    final res = await productRepository.createProduct(
      productionDate: productionDate,
      estimatedPricePerUnit: estimatedPricePerUnit,
      quantity: quantity,
      unit: unit,
      description: description,
      category: category,
      title: title,
      media: media,
    );

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }

  updateProduct({
    required String productId,
    required String productionDate,
    required int estimatedPricePerUnit,
    required int quantity,
    required String unit,
    required String description,
    required int category,
    required int title,
    required List<File> media,
    required List<Photos> deletedMedia,
    int? mediaId,
  }) async {
    emit(CommonLoading());

    final res = await productRepository.updateProduct(
      productId: productId,
      productionDate: productionDate,
      estimatedPricePerUnit: estimatedPricePerUnit,
      quantity: quantity,
      unit: unit,
      description: description,
      category: category,
      title: title,
      media: media,
      deletedMedia: deletedMedia,
      mediaId: mediaId,
    );

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
