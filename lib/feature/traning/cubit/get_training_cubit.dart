import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/traning/resources/traning_repository.dart';

class GetTrainingCubit extends Cubit<CommonState> {
  final TrainingRepository traningRepository;
  GetTrainingCubit({required this.traningRepository}) : super(CommonInitial());

  getTrainingList({String searchSlug = ""}) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await traningRepository.getTrainingList(searchSlug: searchSlug);
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  loadMoreTraining({String searchSlug = ""}) async {
    emit(CommonDummyLoading());
    final res = await traningRepository.getTrainingList(
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
        emit(CommonDataFetchSuccess<String>(data: traningRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: traningRepository.getItems));
    }
  }
}
