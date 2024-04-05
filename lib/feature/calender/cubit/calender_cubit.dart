import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/calender/resource/calender_repository.dart';

class CalenderCubit extends Cubit<CommonState> {
  final CalenderRepository calenderRepository;
  CalenderCubit({required this.calenderRepository}) : super(CommonInitial());

  getCalender({required int id, required String ecologicalRegion}) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await calenderRepository.getCalender(
        id: id, ecologicalRegion: ecologicalRegion);
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


  

  loadMoreCalender({
    String? searchItem,
    required int id,
    required String ecologicalRegion,
  }) async {
    emit(CommonDummyLoading());
    final res = await calenderRepository.getCalender(
      isLoadMore: true,
      id: id,
      ecologicalRegion: ecologicalRegion,
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
        emit(CommonDataFetchSuccess<String>(data: calenderRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: calenderRepository.getItems));
    }
  }
}
