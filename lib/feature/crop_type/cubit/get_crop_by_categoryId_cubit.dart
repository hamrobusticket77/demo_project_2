import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/crop_type/resource/crop_repository.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';

class GetCropByCategoryIdCubit extends Cubit<CommonState> {
  final CropRepository cropRepository;
  GetCropByCategoryIdCubit({
    required this.cropRepository,
  }) : super(CommonInitial());

  getCropByCategoryId(int cropTypeId) async {
    emit(CommonLoading());
    final res = await cropRepository.getCropByCategoryId(cropTypeId);
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<CropTypeModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
