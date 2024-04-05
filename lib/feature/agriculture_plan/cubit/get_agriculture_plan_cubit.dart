import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class GetAgricultureCubit extends Cubit<CommonState> {
  final AgricultureRepository agricultureRepository;
  GetAgricultureCubit({required this.agricultureRepository})
      : super(CommonInitial());

  getAgriculturePlan() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await agricultureRepository.getagricultureplanlist();
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

  loadMoreAgriculturePlan({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await agricultureRepository.getagricultureplanlist(
      isLoadMore: true,
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
        emit(CommonDataFetchSuccess<String>(
            data: agricultureRepository.getItems));
      }
    } else {
      emit(
          CommonDataFetchSuccess<String>(data: agricultureRepository.getItems));
    }
  }
}
