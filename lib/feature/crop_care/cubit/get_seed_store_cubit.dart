import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';

class GetSeedStoreCubit extends Cubit<CommonState> {
  final CropCareRepository cropCareRepository;
  GetSeedStoreCubit({
    required this.cropCareRepository,
  }) : super(CommonInitial());

  getSeedStore({String searchSlug = ""}) async {
    emit(CommonLoading());
    final res = await cropCareRepository.getSeedStore(searchSlug: searchSlug);
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

  loadMoreSeedStore({String searchSlug = ""}) async {
    emit(CommonDummyLoading());
    final res = await cropCareRepository.getSeedStore(
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
        emit(CommonDataFetchSuccess<String>(data: cropCareRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: cropCareRepository.getItems));
    }
  }
}
