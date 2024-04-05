import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';

class ProductCubit extends Cubit<CommonState> {
  // final CreateProductCubit createProductCubit;
  final ProductRepository productRepository;

  // StreamSubscription? createProductCubitStream;

  ProductCubit({
    required this.productRepository,
    // required this.createProductCubit,
  }) : super(CommonInitial()) {
    // createProductCubitStream = createProductCubit.stream.listen((event) {
    //   if (state is CommonSuccess) {
    //     getProduct();
    //   }
    // });
  }

  getProduct({String searchSlug = ""}) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await productRepository.getProduct(searchSlug: searchSlug);
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }

  loadMoreProduct({String searchSlug = ""}) async {
    emit(CommonDummyLoading());
    final res = await productRepository.getProduct(
      isLoadMore: true,
      searchSlug: searchSlug,
    );
    if (res.status == Status.success) {
      if (res.data != null) {
        if (res.data!.isEmpty) {
          emit(const CommonNoData());
        } else {
          emit(
            CommonDataFetchSuccess<String>(data: res.data!),
          );
        }
      } else {
        emit(CommonDataFetchSuccess<String>(data: productRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: productRepository.getItems));
    }
  }
}
