import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';

class GetDoctorRecordCubit extends Cubit<CommonState> {
  final CropCareRepository cropCareRepository;
  GetDoctorRecordCubit({
    required this.cropCareRepository,
  }) : super(CommonInitial());

  getDoctorRecord({
    String searchSlug = "",
    String? type,
    String? category,
  }) async {
    emit(CommonLoading());
    final res = await cropCareRepository.getDoctorRecord(
      searchSlug: searchSlug,
      type: type,
      category: category,
    );
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }

  loadMoreDoctorRecord({
    String searchSlug = "",
    String? type,
    String? category,
  }) async {
    emit(CommonDummyLoading());
    final res = await cropCareRepository.getDoctorRecord(
      isLoadMore: true,
      searchSlug: searchSlug,
      type: type,
      category: category,
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
        emit(CommonDataFetchSuccess<String>(data: cropCareRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: cropCareRepository.getItems));
    }
  }
}
