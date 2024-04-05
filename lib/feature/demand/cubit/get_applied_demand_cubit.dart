import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';

import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class GetAppliedDemandCubit extends Cubit<CommonState> {
  final DemandRepository demandlistRepository;
  GetAppliedDemandCubit({required this.demandlistRepository})
      : super(CommonInitial());

  getAppliedDemand() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await demandlistRepository.getAppliedDemand();
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

  loadMoreAppliedDemand({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await demandlistRepository.getAppliedDemand(
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
            data: demandlistRepository.getDemandItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: demandlistRepository.getDemandItems));
    }
  }
}
