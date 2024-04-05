import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';

class ProductCategoryCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;

  ProductCategoryCubit({
    required this.productRepository,
  }) : super(CommonInitial());

  getProductCategory(String type) async {
    emit(CommonLoading());
    final res = await productRepository.getProductCategoryList(type);

    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        List<CommonDropDownType> _data = [];
        _data.add(CommonDropDownType.all());

        for (var value in res.data!) {
          CommonDropDownType(
            type: "",
            en: value.title,
            ne: value.title,
            id: value.id,
          );
          _data.add(CommonDropDownType(
            type: "",
            en: value.title,
            ne: value.title,
            id: value.id,
          ));
        }
        emit(CommonDataFetchSuccess<CommonDropDownType>(data: _data));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
