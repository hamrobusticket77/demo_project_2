import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';

class DeleteProductCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  DeleteProductCubit({required this.productRepository})
      : super(CommonInitial());

  deleteProduct({
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await productRepository.deleteProduct(id: id);

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
